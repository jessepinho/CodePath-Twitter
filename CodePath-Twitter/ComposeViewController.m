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

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Compose";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendTweet)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)sendTweet {
    [[TwitterClient sharedInstance] sendTweet:nil withCompletion:^(Tweet *tweet, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
@end
