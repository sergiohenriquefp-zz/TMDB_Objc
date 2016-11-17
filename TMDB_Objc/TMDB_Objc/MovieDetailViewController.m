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
    
    if (![MyFunctions isStringEmpty:self.movieObj.urlPoster]) {
        [self.ivPoster loadImageFromUrlString:self.movieObj.urlPoster];
    }
    else{
        [self.ivPoster setImage:[UIImage imageNamed:@"placeholder_poster"]];
    }
    
    [self.lRelease setText:[DateUtils showNiceDate:self.movieObj.releaseDate]];
    
    if ([MyFunctions isStringEmpty:[self.movieObj getGenresString]]) {
        [self.lGenre setText:@"-"];
    }
    else{
        [self.lGenre setText:[self.movieObj getGenresString]];
    }
    
    if ([MyFunctions isStringEmpty:self.movieObj.overview]) {
        [self.lOverview setText:@"-"];
    }
    else{
        [self.lOverview setText:self.movieObj.overview];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
