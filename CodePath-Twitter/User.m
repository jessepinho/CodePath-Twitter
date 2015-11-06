//
//  User.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/4/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "TwitterClient.h"
#import "User.h"

NSString * const UserDidLogInNotification = @"UserDidLogInNotification";
NSString * const UserDidLogOutNotification = @"UserDidLogOutNotification";

@interface User ()
@property (nonatomic, strong) NSDictionary *dictionary;
@end

@implementation User
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.tagline = dictionary[@"description"];
    }
    return self;
}

static User *_currentUser = nil;
NSString * const kCurrentUserKey = @"kCurrentUserKey";

+ (User *)currentUser {
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

+ (void)setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;

    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)logOut {
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];

    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogOutNotification object:nil];
}
@end
