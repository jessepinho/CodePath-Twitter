//
//  TweetCell.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "TweetCell.h"
#import "TweetDateFormatter.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface TweetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@end

@implementation TweetCell
- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.timeLabel.text = [TweetDateFormatter stringFromDate:tweet.createdAt];
    self.tweetLabel.text = tweet.text;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    [self.profileImageView setImageWithURL:tweet.user.profileImageURL];
    [self.tweetLabel sizeToFit];

    [self setUpGestureRecognizers];
}

- (void)profileImageOrScreenNameWasTapped {
    [self.delegate tweetCell:self profileImageOrScreenNameWasTappedOnTweet:self.tweet];
}

- (void)setUpGestureRecognizers {
    UITapGestureRecognizer *profileImageTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageOrScreenNameWasTapped)];
    [self.profileImageView addGestureRecognizer:profileImageTapGestureRecognizer];
    UITapGestureRecognizer *usernameTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageOrScreenNameWasTapped)];
    [self.screenNameLabel addGestureRecognizer:usernameTapGestureRecognizer];
}
@end
