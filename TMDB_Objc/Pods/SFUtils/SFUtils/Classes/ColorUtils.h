//
//  ColorUtils.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtils : NSObject

+ (UIColor *)colorFromRGB:(NSString *)rgbValue;
+ (UIColor *)colorFromRGB:(NSString *)rgbValue withAlpha:(float)alpha;

@end
