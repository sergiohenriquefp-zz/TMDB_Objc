//
//  API.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "ILMovieDBConstants.h"


NSString * const kILMovieDBBaseURL = @"http://api.themoviedb.org/3/";
NSString * const kILMovieDBBaseURLSSL = @"https://api.themoviedb.org/3/";

typedef void (^ILMovieDBClientResponseBlock)(id responseObject, NSError *error);

@interface API : AFHTTPRequestOperationManager

@property (nonatomic, copy) NSString *apiKey;
@property (strong, nonatomic) NSMutableArray *genres;

+ (instancetype)sharedClient;

- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters block:(ILMovieDBClientResponseBlock)block;
- (void)verifyGenres;

@end
