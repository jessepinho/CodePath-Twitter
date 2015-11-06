//
//  TweetCell.h
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "Tweet.h"
#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (nonatomic, strong) Tweet *tweet;
@end
