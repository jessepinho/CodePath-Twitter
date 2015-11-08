//
//  TwitterClient.h
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/4/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "Tweet.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;
- (void)homeTimelineWithParams:(NSMutableDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)sendTweet:(Tweet *)tweet withCompletion:(void (^)(Tweet *tweet, NSError *error))completion;
- (void)retweetTweet:(Tweet *)tweet withCompletion:(void (^)(Tweet *tweet, NSError *error))completion;
- (void)likeTweet:(Tweet *)tweet withCompletion:(void (^)(Tweet *tweet, NSError *error))completion;
@end
