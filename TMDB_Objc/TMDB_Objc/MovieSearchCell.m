//
//  MovieSearchCell.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "MovieSearchCell.h"
#import <UIKit/UIKit.h>

@implementation MovieSearchCell

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
    if (![StringUtils isStringEmpty:self.theObj.urlPoster]) {
        [self.ivPhoto loadImageFromUrlString:[[API sharedClient] completePathForPoster:self.theObj.urlPoster width:self.ivPhoto.frame.size.width]];
    }
    else{
        [self.ivPhoto setImage:[UIImage imageNamed:@"placeholder_poster"]];
    }
    [self.ivPhoto setContentMode:UIViewContentModeScaleAspectFill];
}

@end

