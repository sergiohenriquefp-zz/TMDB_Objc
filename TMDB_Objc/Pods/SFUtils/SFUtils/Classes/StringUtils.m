//
//  StringUtils.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

//Formatted
+(NSString*)formattedEmptyString:(NSString *)string default:(NSString *)defaultString{
    
    if ([StringUtils isStringEmpty:string]) {
        return defaultString;
    }
    
    return string;
}

//Validations
+ (BOOL)isStringEmpty:(NSString *)string{
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        // it's empty or contains only white spaces
        return YES;
    }
    
    return NO;
}

+ (BOOL)hasOnlyNumber:(NSString *)string{
    
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    
    if ([_NumericOnly isSupersetOfSet: myStringSet])
    {
        return true;
    }
    
    return false;
}

//Counts
+ (int)upperCaseCount:(NSString *)string{
    
    int count=0;
    for (int i = 0; i < [string length]; i++) {
        BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[string characterAtIndex:i]];
        if (isUppercase == YES)
            count++;
    }
    
    return count;
}

+ (int)numberCount:(NSString *)string{
    
    int count=0;
    for (int i = 0; i < [string length]; i++) {
        BOOL isNumber= [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:i]];
        if (isNumber == YES)
            count++;
    }
    
    return count;
}

//Attributed
+ (NSMutableAttributedString *)getUnderlineAttributedText:(NSString*)text color:(UIColor *)color{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attrString setAttributes:@{NSForegroundColorAttributeName:color,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[attrString length])];
    
    return attrString;
}

+ (NSMutableAttributedString *)getAttributedTextWithTexts:(NSArray *)texts fonts:(NSArray *)fonts colors:(NSArray *)colors{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    int i = 0;
    
    for (NSString *text in texts) {
        
        UIFont *partFont = fonts[i];
        NSDictionary *partDict = [NSDictionary dictionaryWithObject:partFont forKey:NSFontAttributeName];
        NSMutableAttributedString *parAttrString = [[NSMutableAttributedString alloc] initWithString:text attributes:partDict];
        NSRange partRange = NSMakeRange(0, text.length);
        [parAttrString addAttribute:NSForegroundColorAttributeName value:colors[i] range:partRange];
        [attrString appendAttributedString:parAttrString];
        i++;
    }
    
    return attrString;
}

//Range
+ (NSRange)getRangeOfFullString:(NSString *)fullString partString:(NSString *)partString{
    
    NSMutableAttributedString *mutableString = nil;
    mutableString = [[NSMutableAttributedString alloc] initWithString:fullString];
    
    //  enumerate matches
    NSRange range = NSMakeRange(0,[fullString length]);
    
    NSRange rangeReturn = [fullString rangeOfString:partString options:0 range:range];
    
    return rangeReturn;
}

@end
