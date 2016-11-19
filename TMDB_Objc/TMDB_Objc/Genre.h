//
//  Genre.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 16/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Genre : NSObject

@property (readwrite) int objId;
@property (strong, nonatomic) NSString *name;

+ (NSMutableArray *)getListJson:(NSArray *)array;
+ (Genre *)getObjectJson:(NSDictionary *)dictionary;

@end
