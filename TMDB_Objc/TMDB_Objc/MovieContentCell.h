//
//  MovieContentCell.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieContentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *vBack;
@property (strong, nonatomic) IBOutlet UIImageView *ivPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lName;
@property (strong, nonatomic) IBOutlet UILabel *lGenre;
@property (strong, nonatomic) IBOutlet UILabel *lDate;
@property (strong, nonatomic) Movie *theObj;

- (void)populateWithObject:(Movie *)obj;

@end

