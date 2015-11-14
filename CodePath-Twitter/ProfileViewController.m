//
//  ProfileViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/14/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Profile";
    [self setUpUserViews];
}

- (void)setUpUserViews {
    self.descriptionLabel.text = self.user.userDescription;
    [self.descriptionLabel sizeToFit];
    self.followersLabel.text = [NSString stringWithFormat:@"%@ followers", self.user.followersCount];
    self.followingLabel.text = [NSString stringWithFormat:@"%@ following", self.user.friendsCount];
    self.nameLabel.text = self.user.name;
    [self.profileImageView setImageWithURL:self.user.profileImageURL];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.tweetsLabel.text = [NSString stringWithFormat:@"%@ tweets", self.user.statusesCount];
}
@end
