//
//  LoginViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/4/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "LoginViewController.h"
#import "ContainerViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            [self presentViewController:[[ContainerViewController alloc] init] animated:YES completion:nil];
        } else {
        }
    }];
}
@end
