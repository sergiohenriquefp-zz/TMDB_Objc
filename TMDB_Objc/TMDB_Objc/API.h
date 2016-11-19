//
//  API.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#define kHostURL @"https://api.themoviedb.org/3/"
#define kHostImageURL @"https://image.tmdb.org/t/p/"
#define kAPI @"1f54bd990f1cdfb230adb312546d765d"

#define kEndPointSearch @"search/movie"
#define kEndPointUpcoming @"movie/upcoming"
#define kEndPointGenres @"genre/list"
#define kEndPointConfiguration @"configuration"

#define kDefaultBackdropSize @[@"w300",@"w780",@"w1280",@"original"]
#define kDefaultPosterSize @[@"w92",@"w154",@"w185",@"w342",@"w500",@"w780",@"original"]

typedef void (^APIResponseBlock)(id responseObject, NSError *error);

@interface API : AFHTTPRequestOperationManager

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *baseImageURL;
@property (strong, nonatomic) NSMutableArray *genres;
@property (readwrite) Boolean isGenreVerified;
@property (readwrite) Boolean isConfigurationVerified;
@property (strong, nonatomic) NSMutableArray *posterSizes;
@property (strong, nonatomic) NSMutableArray *backdropSizes;

+ (instancetype)sharedClient;

- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters block:(APIResponseBlock)block;

- (void)searchMoviesWithQuery:(NSString *)query page:(int)page block:(APIResponseBlock)block;
- (void)upcomingMoviesWithPage:(int)page block:(APIResponseBlock)block;
- (void)verifyGenres;
- (void)verifyConfiguration;

- (NSString *)completePathForPoster:(NSString *)path width:(CGFloat)width;
- (NSString *)completePathForBackdrop:(NSString *)path width:(CGFloat)width;

- (NSString *)generateImageWithPath:(NSString *)path size:(NSString *)size;

@end
