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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUserViews];
}

- (void)setUpUserViews {
    self.descriptionLabel.text = self.user.description;
    self.nameLabel.text = self.user.name;
    [self.profileImageView setImageWithURL:self.user.profileImageURL];
    self.screenNameLabel.text = self.user.screenName;
}
@end
