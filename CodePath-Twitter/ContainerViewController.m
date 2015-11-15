//
//  LoggedInContainerViewController.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/14/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "ContainerViewController.h"
#import "TweetsViewController.h"
#import "MenuViewController.h"

@interface ContainerViewController () <MenuViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) UIViewController *contentViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic) BOOL menuIsOpen;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (nonatomic) CGFloat originalLeftMargin;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;
- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentViewController = [TweetsViewController withTimelineType:TimelineTypeHome];
    [self setUpContentViewShadow];
    [self setUpMenuViewController];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    if (self.contentViewController) {
        [self closeMenu];
    }

    if (self.contentViewController) {
        [self removeContentViewController];
    }

    UINavigationController *nvc = [self navigationControllerWithRootViewController:contentViewController];
    contentViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                                              style:UIBarButtonItemStylePlain
                                                                                             target:self
                                                                                             action:@selector(openMenu)];
    [nvc willMoveToParentViewController:self];
    [self addChildViewController:nvc];
    [self.contentView addSubview:nvc.view];
    nvc.view.frame = self.contentView.frame;
    [nvc didMoveToParentViewController:self];

    _contentViewController = nvc;
}

- (void)setUpContentViewShadow {
    self.contentView.layer.masksToBounds = NO;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.layer.shadowRadius = 3;
    self.contentView.layer.shadowOpacity = 0.35;
}

- (UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:viewController];
    nvc.navigationBar.barTintColor = [UIColor colorWithRed:85.0f/255.0f green:172.0f/255.0f blue:238.0/255.0f alpha:1];
    nvc.navigationBar.tintColor = [UIColor whiteColor];
    nvc.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor] };
    return nvc;
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
    self.menuIsOpen = NO;
}

- (void)openMenu {
    self.menuIsOpen = YES;
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

- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender {
    [self closeMenu];
}

- (void)menuViewController:(MenuViewController *)menuViewController didChooseViewController:(UIViewController *)viewController {
    self.contentViewController = viewController;
}

- (void)setMenuIsOpen:(BOOL)menuIsOpen {
    _menuIsOpen = menuIsOpen;
    self.tapGestureRecognizer.enabled = menuIsOpen;
    self.contentViewController.view.userInteractionEnabled = !menuIsOpen;

    [UIView animateWithDuration:0.35 animations:^{
        self.leftMarginConstraint.constant = menuIsOpen ? 80 : 0;
        [self.view layoutIfNeeded];
    }];
}
@end
