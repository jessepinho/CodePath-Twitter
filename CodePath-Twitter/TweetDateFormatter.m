//
//  TweetDateFormatter.m
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import "TweetDateFormatter.h"

@implementation TweetDateFormatter
- (id)init {
    self = [super init];
    if (self) {
        self.dateStyle = NSDateFormatterShortStyle;
        self.timeStyle = NSDateFormatterShortStyle;
    }
    return self;
}

+ (NSString *)stringFromDate:(NSDate *)date {
    TweetDateFormatter *formatter = [[TweetDateFormatter alloc] init];
    return [formatter stringFromDate:date];
}
@end
