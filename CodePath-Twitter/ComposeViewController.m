//
//  ComposeViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/6/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "ComposeViewController.h"
#import "Tweet.h"
#import "TwitterClient.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpTextView];
    if (!self.tweet) {
        self.tweet = [[Tweet alloc] init];
    }
}

- (void)setUpNavBar {
    self.title = @"Compose";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendTweet)];
}

- (void)setUpTextView {
    self.tweetTextView.text = @"";
    [self.tweetTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)sendTweet {
    self.tweet.text = self.tweetTextView.text;
    [[TwitterClient sharedInstance] sendTweet:self.tweet withCompletion:^(Tweet *tweet, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
@end
