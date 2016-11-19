//
//  MovieContentCell.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "MovieContentCell.h"
#import <UIKit/UIKit.h>
#import "Movie.h"

@implementation MovieContentCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)populateWithObject:(Movie *)obj{
    
    [self setTheObj:obj];
    [self.lName setText:self.theObj.name];
    
    if (![StringUtils isStringEmpty:self.theObj.urlBackdrop]) {
        [self.ivPhoto loadImageFromUrlString:[[API sharedClient] completePathForBackdrop:self.theObj.urlBackdrop width:self.ivPhoto.frame.size.width]];
    }
    else{
        [self.ivPhoto setImage:[UIImage imageNamed:@"placeholder_backdrop"]];
    }
    [self.ivPhoto setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.lDate setText:[NSDateFormatter localizedStringFromDate:obj.releaseDate
                                                       dateStyle:NSDateFormatterShortStyle
                                                       timeStyle:NSDateFormatterNoStyle]];
    
    [self.lGenre setText:[obj getGenresString]];
    
    self.vBack.layer.masksToBounds = NO;
    self.vBack.layer.shadowOffset = CGSizeMake(0, 5);
    self.vBack.layer.shadowRadius = 5;
    self.vBack.layer.shadowOpacity = 0.33;
}

@end
