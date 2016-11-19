//
//  StringUtils.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

//Formatted
+(NSString*)formattedEmptyString:(NSString *)string default:(NSString *)defaultString;

//Validations
+ (BOOL)isStringEmpty:(NSString *)string;
+ (BOOL)hasOnlyNumber:(NSString *)string;

//Counts
+ (int)upperCaseCount:(NSString *)string;
+ (int)numberCount:(NSString *)string;

//Attributed
+ (NSMutableAttributedString *)getUnderlineAttributedText:(NSString*)text color:(UIColor *)color;
+ (NSMutableAttributedString *)getAttributedTextWithTexts:(NSArray *)texts fonts:(NSArray *)fonts colors:(NSArray *)colors;

//Range
+ (NSRange)getRangeOfFullString:(NSString *)fullString partString:(NSString *)partString;

@end
