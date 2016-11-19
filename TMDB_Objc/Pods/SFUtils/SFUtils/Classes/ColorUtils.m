//
//  ColorUtils.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "ColorUtils.h"

@implementation ColorUtils

+ (UIColor *)colorFromRGB:(NSString *)rgbValue{
    
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:rgbValue] scanHexInt:&colorInt];
    
    return [UIColor colorWithRed:((float)((colorInt & 0xFF0000) >> 16))/255.0
                           green:((float)((colorInt & 0xFF00) >> 8))/255.0
                            blue:((float)(colorInt & 0xFF))/255.0 alpha:1.0];
    
}
+ (UIColor *)colorFromRGB:(NSString *)rgbValue withAlpha:(float)alpha{
    
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:rgbValue] scanHexInt:&colorInt];
    
    return [UIColor colorWithRed:((float)((colorInt & 0xFF0000) >> 16))/255.0
                           green:((float)((colorInt & 0xFF00) >> 8))/255.0
                            blue:((float)(colorInt & 0xFF))/255.0 alpha:alpha];
    
}

@end
