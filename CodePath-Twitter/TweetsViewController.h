//
//  TweetsViewController.h
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "TwitterClient.h"
#import <UIKit/UIKit.h>

@interface TweetsViewController : UIViewController
@property (nonatomic) enum TimelineType timelineType;

+ (id)withTimelineType:(TimelineType)timelineType;
@end
