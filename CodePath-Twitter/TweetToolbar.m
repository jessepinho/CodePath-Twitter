//
//  TweetToolbar.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/6/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "TweetToolbar.h"

@implementation TweetToolbar
- (void)awakeFromNib {
    self.tintColor = [UIColor colorWithRed:85.0f/255.0f green:172.0f/255.0f blue:238.0/255.0f alpha:1];
    [self setUpItems];
}

- (void)setUpItems {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *replyButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Reply"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *retweetButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Retweet"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *likeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Like"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.items = @[replyButton, spacer, retweetButton, spacer, likeButton];
}
@end
