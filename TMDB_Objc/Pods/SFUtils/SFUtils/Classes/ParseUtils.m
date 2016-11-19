//
//  ParseUtils.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "ParseUtils.h"

@implementation ParseUtils

//Append Post
+ (id)assertObjectNullForDictionary:(id)object{
    
    if (object) {
        
        return object;
    }
    
    return [NSNull null];
}

+ (id)assertObjectNullForValue:(id)object defaultValue:(id)defaultValue{
    
    if(([object isKindOfClass:[NSNull class]] == NO) && (object != nil))
    {
        return object;
    }
    
    return defaultValue;
    
}

@end
