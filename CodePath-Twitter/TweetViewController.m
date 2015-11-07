//
//  TweetViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "ComposeViewController.h"
#import "TweetDateFormatter.h"
#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
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
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onRetweetButton:(id)sender {
}

- (IBAction)onLikeButton:(id)sender {
}
@end
