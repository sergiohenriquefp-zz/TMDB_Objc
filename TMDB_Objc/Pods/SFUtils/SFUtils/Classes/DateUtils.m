//
//  DateUtils.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 16/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSDate *)getFormatedDate:(NSString *)localDate{
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:localDate options:0 range:NSMakeRange(0, [localDate length])];
    if ([result resultType] == NSTextCheckingTypeDate) {
        NSDate * date = [result date];
        if (date) {
            return date;
        }
    }
    
    NSArray *dateFormatsToTry = @[@"yyyy-MM-dd",@"yyyy-MM-dd'T'HH:mmZZZZ", @"yyyy-MM-dd'T'HH:mm:ssZZZ",@"yyyy-MM-dd HH:mm:ss zzz",@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    for (NSString * format in dateFormatsToTry) {
        [dateFormatter setDateFormat:format];
        NSDate *date = [dateFormatter dateFromString:localDate];
        if (date) {
            return date;
        }
    }
    
    return [NSDate new];
}

+(NSString *)getDateAlphabetic:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *myFormattedDate = [dateFormat stringFromDate:date];
    return myFormattedDate;
}

@end
