//
//  DateUtils.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 16/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+(NSDate *)getFormatedDate:(NSString *)localDate;

+(NSString *)getDateAlphabetic:(NSDate *)date;

@end
