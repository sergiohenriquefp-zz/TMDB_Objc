//
//  ValidationUtils.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 19/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidationUtils : NSObject

+ (BOOL)validateCPF:(NSString *)cpf;
+ (BOOL)validateEmail:(NSString*)email;

@end
