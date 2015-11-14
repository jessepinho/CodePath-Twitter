//
//  LoggedInMenuViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/14/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "LoggedInViewController.h"
#import "MenuViewController.h"
#import "ProfileViewController.h"

@interface MenuViewController ()
- (IBAction)onHomeButton:(id)sender;
- (IBAction)onProfileButton:(id)sender;
- (IBAction)onMentionsButton:(id)sender;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onHomeButton:(id)sender {
    [self.delegate menuViewController:self didChooseViewController:[[LoggedInViewController alloc] init]];
}

- (IBAction)onProfileButton:(id)sender {
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    vc.user = [User currentUser];
    [self.delegate menuViewController:self didChooseViewController:vc];
}

- (IBAction)onMentionsButton:(id)sender {
}
@end
