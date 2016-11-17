//
//  API.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "API.h"

@implementation API

+ (instancetype)sharedClient {
    static API *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if DEBUG
        NSString *baseUrl = kILMovieDBBaseURL;
#else
        NSString *baseUrl = kILMovieDBBaseURLSSL;
#endif
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer new];
        _sharedClient.genres = [NSMutableArray array];
    });
    return _sharedClient;
}

#pragma mark - Requests

- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters block:(ILMovieDBClientResponseBlock)block {
    NSParameterAssert(self.apiKey);
    NSParameterAssert(block);
    
    AFHTTPRequestOperation *requestOperation;
    NSMutableDictionary *params = parameters ? [parameters mutableCopy] : [NSMutableDictionary new];
    params[@"api_key"] = self.apiKey;
    
    if ([path rangeOfString:@":id"].location != NSNotFound) {
        NSParameterAssert(parameters[@"id"]);
        path = [path stringByReplacingOccurrencesOfString:@":id" withString:parameters[@"id"]];
    }
    
    requestOperation = [self GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
    
    return requestOperation;
}

- (void)verifyGenres{

    if (self.genres.count == 0) {
        
        [self GET:kILMovieDBGenreList parameters:nil block:^(id responseObject, NSError *error) {
            if (!error) {
                NSArray * array = responseObject[@"genres"];
                
                self.genres = [Genre getListJson:array];
            }
        }];
    }
}

@end
