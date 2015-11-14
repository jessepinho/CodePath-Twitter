//
//  User.h
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/4/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLogInNotification;
extern NSString * const UserDidLogOutNotification;

@interface User : NSObject
@property (nonatomic, strong) NSNumber *followersCount;
@property (nonatomic, strong) NSNumber *friendsCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *profileImageURL;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSNumber *statusesCount;
@property (nonatomic, strong) NSString *userDescription;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;
+ (void)logOut;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
