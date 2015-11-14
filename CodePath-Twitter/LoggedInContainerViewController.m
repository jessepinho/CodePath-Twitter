//
//  LoggedInContainerViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/14/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "LoggedInContainerViewController.h"
#import "LoggedInViewController.h"
#import "MenuViewController.h"

@interface LoggedInContainerViewController () <MenuViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) UIViewController *contentViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic) CGFloat originalLeftMargin;

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;
@end

@implementation LoggedInContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentViewController = [[LoggedInViewController alloc] init];
    [self setUpMenuViewController];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    if (self.contentViewController) {
        [self closeMenu];
    }

    if (self.contentViewController) {
        [self removeContentViewController];
    }

    [contentViewController willMoveToParentViewController:self];
    [self addChildViewController:contentViewController];
    [self.contentView addSubview:contentViewController.view];
    contentViewController.view.frame = self.contentView.frame;
    [contentViewController didMoveToParentViewController:self];

    _contentViewController = contentViewController;
}

- (void)setUpMenuViewController {
    MenuViewController *vc = [[MenuViewController alloc] init];
    [vc willMoveToParentViewController:self];
    [self addChildViewController:vc];
    [self.menuView addSubview:vc.view];
    vc.view.frame = self.menuView.frame;
    vc.delegate = self;
    [vc didMoveToParentViewController:self];
}

- (void)closeMenu {
    [UIView animateWithDuration:0.35 animations:^{
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)openMenu {
    [UIView animateWithDuration:0.35 animations:^{
        self.leftMarginConstraint.constant = self.view.frame.size.width - 50;
        [self.view layoutIfNeeded];
    }];
}

- (void)removeContentViewController {
    [self.contentViewController willMoveToParentViewController:nil];
    [self.contentViewController removeFromParentViewController];
    [self.contentViewController.view removeFromSuperview];
    [self.contentViewController didMoveToParentViewController:nil];
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalLeftMargin = self.leftMarginConstraint.constant;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        if (velocity.x > 0) {
            [self openMenu];
        } else {
            [self closeMenu];
        }
    }
}

- (void)menuViewController:(MenuViewController *)menuViewController didChooseViewController:(UIViewController *)viewController {
    self.contentViewController = viewController;
}
@end
