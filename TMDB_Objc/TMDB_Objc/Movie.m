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
    
    [obj setObjId:[[ParseUtils assertObjectNullForValue:[dictionary valueForKey:@"id"] defaultValue:@0] intValue]];
    [obj setName:[ParseUtils assertObjectNullForValue:[dictionary valueForKey:@"title"] defaultValue:@""]];
    [obj setUrlPoster:[ParseUtils assertObjectNullForValue:[dictionary valueForKey:@"poster_path"] defaultValue:@""]];
    [obj setUrlBackdrop:[ParseUtils assertObjectNullForValue:[dictionary valueForKey:@"backdrop_path"] defaultValue:@""]];
    [obj setReleaseDate:[DateUtils getFormatedDate:[dictionary valueForKey:@"release_date"]]];
    [obj setOverview:[ParseUtils assertObjectNullForValue:[dictionary valueForKey:@"overview"] defaultValue:@""]];
    
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
