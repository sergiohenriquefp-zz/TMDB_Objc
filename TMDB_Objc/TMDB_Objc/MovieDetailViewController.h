//
//  MovieDetailViewController.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btBack;
@property (weak, nonatomic) IBOutlet UIView *vBack;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *ivPoster;

@property (weak, nonatomic) IBOutlet UILabel *lTitle;
@property (weak, nonatomic) IBOutlet UILabel *lReleaseTop;
@property (weak, nonatomic) IBOutlet UILabel *lRelease;
@property (weak, nonatomic) IBOutlet UILabel *lGenreTop;
@property (weak, nonatomic) IBOutlet UILabel *lGenre;
@property (weak, nonatomic) IBOutlet UILabel *lOverviewTop;
@property (weak, nonatomic) IBOutlet UILabel *lOverview;

@property (strong, nonatomic) Movie *movieObj;

@end
