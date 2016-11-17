//
//  Genre.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 16/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "Genre.h"

@implementation Genre

@synthesize objId;
@synthesize name;

+ (NSMutableArray *)getListJson:(NSArray *)array{
    
    NSMutableArray *arrayObj = [NSMutableArray array];
    
    for (NSDictionary * dicObj in array) {
        
        [arrayObj addObject:[Genre getObjectJson:dicObj]];
    }
    
    return arrayObj;
    
}

+ (Genre *)getObjectJson:(NSDictionary *)dictionary{
    
    Genre *obj = [[Genre alloc] init];
    
    [obj setObjId:[[MyFunctions assertObjectNullForValue:[dictionary valueForKey:@"id"] defaultValue:@0] intValue]];
    [obj setName:[MyFunctions assertObjectNullForValue:[dictionary valueForKey:@"name"] defaultValue:@""]];
    
    return obj;
}

@end
