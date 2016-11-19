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
        NSString *baseUrl = kHostURL;
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer new];
        _sharedClient.apiKey = kAPI;
        _sharedClient.baseImageURL = kHostImageURL;
        _sharedClient.genres = [NSMutableArray array];
        _sharedClient.isGenreVerified = NO;
        _sharedClient.isConfigurationVerified = NO;
        _sharedClient.posterSizes = [NSMutableArray arrayWithArray:kDefaultPosterSize];
        _sharedClient.backdropSizes = [NSMutableArray arrayWithArray:kDefaultBackdropSize];
    });
    return _sharedClient;
}

#pragma mark - Requests

- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters block:(APIResponseBlock)block {
    NSParameterAssert(self.apiKey);
    NSParameterAssert(block);
    
    AFHTTPRequestOperation *requestOperation;
    NSMutableDictionary *params = parameters ? [parameters mutableCopy] : [NSMutableDictionary new];
    params[@"api_key"] = self.apiKey;
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    params[@"language"] = language;
    
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

- (void)searchMoviesWithQuery:(NSString *)query page:(int)page block:(APIResponseBlock)block{

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:page],@"page",query,@"query", nil];
    
    [[API sharedClient] GET:kEndPointSearch parameters:params block:^(id responseObject, NSError *error) {
        block(responseObject,error);
    }];
}

- (void)upcomingMoviesWithPage:(int)page block:(APIResponseBlock)block{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:page],@"page", nil];
    
    [[API sharedClient] GET:kEndPointUpcoming parameters:params block:^(id responseObject, NSError *error) {
        block(responseObject,error);
    }];
}

- (void)verifyGenres{

    if (self.genres.count == 0 || ![API sharedClient].isGenreVerified) {
        
        [self GET:kEndPointGenres parameters:nil block:^(id responseObject, NSError *error) {
            if (!error) {
                [API sharedClient].isGenreVerified = YES;
                NSArray * array = responseObject[@"genres"];
                self.genres = [Genre getListJson:array];
                [UserDefaultsUtils setMutableArrayInfo:self.genres key:@"saved_genres"];
            }
            else{
                self.genres = [UserDefaultsUtils savedMutableArrayInfo:@"saved_genres"];
            }
        }];
    }
}

- (void)verifyConfiguration{
    
    if (![API sharedClient].isConfigurationVerified) {
        
        [self GET:kEndPointConfiguration parameters:nil block:^(id responseObject, NSError *error) {
            if (!error) {
                [API sharedClient].isConfigurationVerified = YES;
                NSDictionary * dicImages = responseObject[@"images"];
                if (dicImages) {
                    
                    [API sharedClient].baseImageURL = [ParseUtils assertObjectNullForValue:[dicImages valueForKey:@"secure_base_url"] defaultValue:kHostImageURL];
                    
                    NSArray * arrayPoster = dicImages[@"poster_sizes"];
                    if (arrayPoster) {
                        [API sharedClient].posterSizes = [NSMutableArray arrayWithArray:arrayPoster];
                    }
                    
                    NSArray * arrayBackdrop = dicImages[@"backdrop_sizes"];
                    if (arrayBackdrop) {
                        [API sharedClient].backdropSizes = [NSMutableArray arrayWithArray:arrayBackdrop];
                    }
                }
            }
        }];
    }
}

- (NSString *)completePathForPoster:(NSString *)path width:(CGFloat)width{
    
    int widthToUse = 0;
    
    for (NSString * widthString in [API sharedClient].posterSizes) {
        
        NSString *noW = [widthString stringByReplacingOccurrencesOfString:@"w" withString:@""];
        
        if ([StringUtils hasOnlyNumber:noW]) {
            
            int widthConverted = [noW intValue];
            
            if (widthConverted >= (int)width && (widthConverted < widthToUse || widthToUse == 0)) {
                widthToUse = widthConverted;
            }
        }
    }
    
    if (widthToUse == 0) {
        if (![[API sharedClient].posterSizes containsObject:@"original"]) {
            return [[API sharedClient] generateImageWithPath:@"" size:@""];
        }
        else{
            return [[API sharedClient] generateImageWithPath:path size:@"original"];
        }
    }
    
    return [[API sharedClient] generateImageWithPath:path size:[NSString stringWithFormat:@"w%d",widthToUse]];
}

- (NSString *)completePathForBackdrop:(NSString *)path width:(CGFloat)width{
    int widthToUse = 0;
    
    for (NSString * widthString in [API sharedClient].backdropSizes) {
        
        NSString *noW = [widthString stringByReplacingOccurrencesOfString:@"w" withString:@""];
        
        if ([StringUtils hasOnlyNumber:noW]) {
            
            int widthConverted = [noW intValue];
            
            if (widthConverted >= (int)width && (widthConverted < widthToUse || widthToUse == 0)) {
                widthToUse = widthConverted;
            }
        }
    }
    
    if (widthToUse == 0) {
        if (![[API sharedClient].backdropSizes containsObject:@"original"]) {
            return [[API sharedClient] generateImageWithPath:@"" size:@""];
        }
        else{
            return [[API sharedClient] generateImageWithPath:path size:@"original"];
        }
    }
    
    return [[API sharedClient] generateImageWithPath:path size:[NSString stringWithFormat:@"w%d",widthToUse]];
}

- (NSString *)generateImageWithPath:(NSString *)path size:(NSString *)size{

    if ([StringUtils isStringEmpty:path]) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@%@/%@?api_key=%@",[API sharedClient].baseImageURL,size,path,[API sharedClient].apiKey];
}

@end
