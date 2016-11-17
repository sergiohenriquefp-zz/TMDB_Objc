//
//  Movie.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (readwrite) int objId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSDate *releaseDate;
@property (strong, nonatomic) NSString *urlPoster;
@property (strong, nonatomic) NSString *urlPosterSmall;
@property (strong, nonatomic) NSString *urlBackdrop;
@property (strong, nonatomic) NSMutableArray *genresID;

+ (NSMutableArray *)getListJson:(NSArray *)array;
+ (Movie *)getObjectJson:(NSDictionary *)dictionary;
- (NSString *)getGenresString;

@end
