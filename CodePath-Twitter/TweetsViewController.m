//
//  TweetsViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "ComposeViewController.h"
#import "ProfileViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TweetsViewController.h"
#import "TweetViewController.h"
#import "TwitterClient.h"

@interface TweetsViewController () <TweetCellDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@end

@implementation TweetsViewController

+ (id)withTimelineType:(TimelineType)timelineType {
    TweetsViewController *vc = [[TweetsViewController alloc] init];
    vc.timelineType = timelineType;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpTable];
    [self fetchTweetsWithCompletion:nil];
}

- (void)fetchTweetsWithCompletion:(void (^)())completion {
    [[TwitterClient sharedInstance] timelineWithType:self.timelineType params:nil completion:^(NSArray *tweets, NSError *error) {
        if (tweets != nil) {
            self.tweets = tweets;
            [self.tableView reloadData];
            if (completion != nil) {
                completion();
            }
        }
    }];
}

- (void)onRefresh {
    [self fetchTweetsWithCompletion:^{
        [self.refreshControl endRefreshing];
    }];
}

- (void)onTweet {
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setUpNavBar {
    self.title = @"Timeline";
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Twitter"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onTweet)];
}

- (void)setUpRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)setUpTable {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    [self setUpRefreshControl];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewController *vc = [[TweetViewController alloc] init];
    vc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tweetCell:(TweetCell *)cell profileImageOrScreenNameWasTappedOnTweet:(Tweet *)tweet {
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    vc.user = tweet.user;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
