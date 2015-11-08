//
//  TwitterClient.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/4/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "Tweet.h"
#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"Plvs5JuvDl437ALopleUMgEzN";
NSString * const kTwitterConsumerSecret = @"0Lf3qlmM9arVr46zqBLk38rUk9xXxunIaSvlnXjq4pfEBtN0Uh";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient ()
@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

- (void)loginWithCompletion:(void (^)(User *, NSError *))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"codepathtwitter://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error) {
        self.loginCompletion(nil, error);
    }];
}

- (void)openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            self.loginCompletion(nil, error);
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the access token");
    }];
}

- (void)homeTimelineWithParams:(NSMutableDictionary *)params completion:(void (^)(NSArray *, NSError *))completion {
    params = params == nil ? [NSMutableDictionary dictionary] : params;
    params[@"include_my_retweet"] = @"t";
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)sendTweet:(Tweet *)tweet withCompletion:(void (^)(Tweet *, NSError *))completion {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = tweet.text;
    if (tweet.inReplyTo) {
        params[@"in_reply_to_status_id"] = tweet.inReplyTo.id;
    }
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)retweetTweet:(Tweet *)tweet withCompletion:(void (^)(Tweet *, NSError *))completion {
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweet.id];

    [self POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}
@end
