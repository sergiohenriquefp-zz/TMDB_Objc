//
//  ParseUtils.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseUtils : NSObject

//Append Post
+ (id)assertObjectNullForDictionary:(id)object;
+ (id)assertObjectNullForValue:(id)object defaultValue:(id)defaultValue;

@end
