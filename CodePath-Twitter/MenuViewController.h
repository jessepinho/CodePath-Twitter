//
//  LoggedInMenuViewController.h
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/14/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>
- (void)menuViewController:(MenuViewController *)menuViewController didChooseViewController:(UIViewController *)viewController;
@end

@interface MenuViewController : UIViewController
@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;
@end
