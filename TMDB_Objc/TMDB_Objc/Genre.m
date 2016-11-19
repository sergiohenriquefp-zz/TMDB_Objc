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
    
    [obj setObjId:[[ParseUtils assertObjectNullForValue:[dictionary valueForKey:@"id"] defaultValue:@0] intValue]];
    [obj setName:[ParseUtils assertObjectNullForValue:[dictionary valueForKey:@"name"] defaultValue:@""]];
    
    return obj;
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.objId = [coder decodeIntForKey:@"objId"];
        self.name = [coder decodeObjectForKey:@"name"];
    }
    
    return self; // this is missing in the example above
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeInt:self.objId forKey:@"objId"];
    [coder encodeObject:self.name forKey:@"name"];
}

@end
