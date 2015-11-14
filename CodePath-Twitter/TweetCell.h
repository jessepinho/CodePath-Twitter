//
//  TweetCell.h
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "Tweet.h"
#import <UIKit/UIKit.h>

@class TweetCell;

@protocol TweetCellDelegate <NSObject>
- (void)tweetCell:(TweetCell *)cell profileImageOrScreenNameWasTappedOnTweet:(Tweet *)tweet;
@end

@interface TweetCell : UITableViewCell
@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@property (nonatomic, strong) Tweet *tweet;
@end
