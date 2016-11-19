//
//  MovieDetailViewController.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lTitle setText:self.movieObj.name];
    
    if (![StringUtils isStringEmpty:self.movieObj.urlPoster]) {
        [self.ivPoster loadImageFromUrlString:[[API sharedClient] completePathForPoster:self.movieObj.urlPoster width:self.ivPoster.frame.size.width]];
    }
    else{
        [self.ivPoster setImage:[UIImage imageNamed:@"placeholder_poster"]];
    }
    
    [self.lRelease setText:[NSDateFormatter localizedStringFromDate:self.movieObj.releaseDate
                                                                              dateStyle:NSDateFormatterLongStyle
                                                                              timeStyle:NSDateFormatterNoStyle]];
    
    if ([StringUtils isStringEmpty:[self.movieObj getGenresString]]) {
        [self.lGenre setText:@"-"];
    }
    else{
        [self.lGenre setText:[self.movieObj getGenresString]];
    }
    
    if ([StringUtils isStringEmpty:self.movieObj.overview]) {
        [self.lOverview setText:@"-"];
    }
    else{
        [self.lOverview setText:self.movieObj.overview];
    }

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.lReleaseTop setText:NSLocalizedString(@"RELEASE_DATE", @"Release Date")];
    [self.lGenreTop setText:NSLocalizedString(@"GENRE", @"Genre")];
    [self.lOverviewTop setText:NSLocalizedString(@"OVERVIEW", @"Overview")];
    
}

- (void)viewDidLayoutSubviews{

    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.lOverview.frame.origin.y + self.lOverview.frame.size.height + 30.0)];
}

- (IBAction)backClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
