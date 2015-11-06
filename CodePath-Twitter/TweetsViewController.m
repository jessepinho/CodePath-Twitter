//
//  TweetsViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "Tweet.h"
#import "TweetCell.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"
#import "User.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTable];
    [self fetchTweets];
}

- (IBAction)onLogOut:(id)sender {
    [User logOut];
}

- (void)fetchTweets {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (tweets != nil) {
            self.tweets = tweets;
            [self.tableView reloadData];
        }
    }];
}

- (void)setUpTable {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}
@end
