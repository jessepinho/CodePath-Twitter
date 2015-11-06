//
//  TweetCell.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell
- (void)setTweet:(Tweet *)tweet {
    self.tweetLabel.text = tweet.text;
    [self.tweetLabel sizeToFit];
}
@end
