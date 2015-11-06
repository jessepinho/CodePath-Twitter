//
//  TweetViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@end

@implementation TweetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Tweet";

    self.nameLabel.text = self.tweet.user.name;
    [self.profileImageView setImageWithURL:self.tweet.user.profileImageURL];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    [self.tweetLabel sizeToFit];
}
@end
