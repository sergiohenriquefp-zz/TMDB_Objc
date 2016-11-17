//
//  Movie.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "Movie.h"
#import "Genre.h"

@implementation Movie

@synthesize objId;
@synthesize name;
@synthesize genre;
@synthesize overview;
@synthesize releaseDate;
@synthesize urlPoster;
@synthesize urlBackdrop;

+ (NSMutableArray *)getListJson:(NSArray *)array{
    
    NSMutableArray *arrayObj = [NSMutableArray array];
    
    for (NSDictionary * dicObj in array) {
        
        [arrayObj addObject:[Movie getObjectJson:dicObj]];
    }
    
    return arrayObj;
    
}

+ (Movie *)getObjectJson:(NSDictionary *)dictionary{
    
    Movie *obj = [[Movie alloc] init];
    
    [obj setObjId:[[MyFunctions assertObjectNullForValue:[dictionary valueForKey:@"id"] defaultValue:@0] intValue]];
    [obj setName:[MyFunctions assertObjectNullForValue:[dictionary valueForKey:@"title"] defaultValue:@""]];
    
    NSString *pathPoster = [MyFunctions assertObjectNullForValue:[dictionary valueForKey:@"poster_path"] defaultValue:@""];
    if ([MyFunctions isStringEmpty:pathPoster]) {
        [obj setUrlPoster:pathPoster];
        [obj setUrlPosterSmall:pathPoster];
    }
    else{
        [obj setUrlPoster:[NSString stringWithFormat:@"%@%@?api_key=%@",@"https://image.tmdb.org/t/p/w500/",pathPoster,[ILMovieDBClient sharedClient].apiKey]];
        [obj setUrlPosterSmall:[NSString stringWithFormat:@"%@%@?api_key=%@",@"https://image.tmdb.org/t/p/w92/",pathPoster,[ILMovieDBClient sharedClient].apiKey]];
    }
    
    NSString *pathBackdrop = [MyFunctions assertObjectNullForValue:[dictionary valueForKey:@"backdrop_path"] defaultValue:@""];
    if ([MyFunctions isStringEmpty:pathBackdrop]) {
        [obj setUrlBackdrop:pathBackdrop];
    }
    else{
        [obj setUrlBackdrop:[NSString stringWithFormat:@"%@%@?api_key=%@",@"https://image.tmdb.org/t/p/w300/",pathBackdrop,[ILMovieDBClient sharedClient].apiKey]];
    }
    
    [obj setReleaseDate:[DateUtils getFormateDateSimple:[dictionary valueForKey:@"release_date"]]];
    
    [obj setOverview:[MyFunctions assertObjectNullForValue:[dictionary valueForKey:@"overview"] defaultValue:@""]];
    
    NSArray * genresArray = dictionary[@"genre_ids"];
    if (genresArray) {
        obj.genresID = [NSMutableArray arrayWithArray:genresArray];
    }
    else{
        obj.genresID = [NSMutableArray array];
    }
    
    return obj;
}

- (NSString *)getGenresString{

    if (self.genresID.count == 0 || [API sharedClient].genres.count == 0) {
        return @"";
    }
    
    NSString * stringToReturn = @"";
    
    for (Genre *objGenre in [API sharedClient].genres) {
        
        for (NSNumber *idGenre in self.genresID) {
            
            if ([[NSNumber numberWithInt:objGenre.objId] isEqual:idGenre]) {
                
                if ([stringToReturn isEqualToString:@""]) {
                    stringToReturn = [NSString stringWithFormat:@"%@",objGenre.name];
                }
                else{
                    stringToReturn = [NSString stringWithFormat:@"%@, %@",stringToReturn, objGenre.name];
                }
            }
        }
    }
    
    return stringToReturn;
}

@end
