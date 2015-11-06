//
//  TweetCell.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "TweetDateFormatter.h"

@interface TweetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end

@implementation TweetCell
- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.timeLabel.text = [TweetDateFormatter stringFromDate:tweet.createdAt];
    self.tweetLabel.text = tweet.text;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    [self.profileImageView setImageWithURL:tweet.user.profileImageURL];
    [self.tweetLabel sizeToFit];
}
@end
