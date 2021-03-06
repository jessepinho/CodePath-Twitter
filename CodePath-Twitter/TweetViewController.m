//
//  TweetViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "ComposeViewController.h"
#import "Tweet.h"
#import "TweetDateFormatter.h"
#import "TweetViewController.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

- (IBAction)onReplyButton:(id)sender;
- (IBAction)onRetweetButton:(id)sender;
- (IBAction)onLikeButton:(id)sender;
@end

@implementation TweetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Tweet";
    [self setUpSubviews];
}

- (void)setUpSubviews {
    self.nameLabel.text = self.tweet.user.name;
    [self.profileImageView setImageWithURL:self.tweet.user.profileImageURL];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.timeLabel.text = [TweetDateFormatter stringFromDate:self.tweet.createdAt];
    self.tweetLabel.text = self.tweet.text;
    [self.tweetLabel sizeToFit];
}

- (IBAction)onReplyButton:(id)sender {
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    Tweet *replyTweet = [[Tweet alloc] init];
    replyTweet.inReplyTo = self.tweet;
    replyTweet.text = [NSString stringWithFormat:@"@%@ ", self.tweet.user.screenName];
    vc.tweet = replyTweet;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onRetweetButton:(id)sender {
    [[TwitterClient sharedInstance] retweetTweet:self.tweet withCompletion:^(Tweet *tweet, NSError *error) {
        if (!error) {
            self.retweetButton.enabled = NO;
        }
    }];
}

- (IBAction)onLikeButton:(id)sender {
    [[TwitterClient sharedInstance] likeTweet:self.tweet withCompletion:^(Tweet *tweet, NSError *error) {
        if (!error) {
            self.likeButton.enabled = NO;
        }
    }];
}
@end
