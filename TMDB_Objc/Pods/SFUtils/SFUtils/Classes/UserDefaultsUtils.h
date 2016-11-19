//
//  UserDefaultsUtils.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

//String
+(NSString*)savedStringInfo:(NSString *)key;
+(void)setStringInfo:(NSString *)info key:(NSString *)key;

//Int
+(int)savedIntInfo:(NSString *)key;
+(void)setIntInfo:(int)info key:(NSString *)key;

//Boolean
+(BOOL)savedBoolInfo:(NSString *)key;
+(void)setBoolInfo:(BOOL)info key:(NSString *)key;

//NSMutableArray
//Dont forget to implement encoder on Object
+(NSMutableArray*)savedMutableArrayInfo:(NSString *)key;
+(void)setMutableArrayInfo:(NSMutableArray *)info key:(NSString *)key;

@end
