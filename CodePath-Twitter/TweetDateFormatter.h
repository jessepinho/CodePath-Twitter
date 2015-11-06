//
//  TweetDateFormatter.h
//  CodePath-Twitter
//
//  Created by Jesse Pinho on 11/5/15.
//  Copyright © 2015 Jesse Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetDateFormatter : NSDateFormatter
+ (NSString *)stringFromDate:(NSDate *)date;
@end
