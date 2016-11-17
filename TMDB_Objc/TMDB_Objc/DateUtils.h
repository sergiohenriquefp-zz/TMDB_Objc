//
//  DateUtils.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 16/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+(NSDate *)getFormateDateSimple:(NSString *)localDate;

+(NSDate *)getFormateDate:(NSString *)localDate;

+(NSString *)showNiceDate:(NSDate *)dateString;

+(NSString *)getDateAlphabetic:(NSDate *)date;

+ (NSString *)getNomeMes:(int)mes;

+ (NSString *) getMinNomeMes:(int)mes;

@end
