//
//  GeneralViewController.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "GeneralViewController.h"
#import "Reachability.h"
#import "MovieDetailViewController.h"

@interface GeneralViewController ()

@end

@implementation GeneralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    [self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (void)callSuccessMessageWithText:(NSString *)text detail:(NSString *)detail{
    
    if (!text) {
        text = @"Success!";
    }
    
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:text
                                                   description:detail
                                                          type:TWMessageBarMessageTypeSuccess
                                                statusBarStyle:UIStatusBarStyleLightContent
                                                      callback:nil];
}

- (void)callInfoMessageWithText:(NSString *)text detail:(NSString *)detail{
    
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:text
                                                   description:detail
                                                          type:TWMessageBarMessageTypeInfo
                                                statusBarStyle:UIStatusBarStyleLightContent
                                                      callback:nil];
}

- (void)callErrorMessageWithText:(NSString *)text detail:(NSString *)detail{
    
    if (!text) {
        text = @"Hm, something went wrong...";
    }
    
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:text
                                                   description:detail
                                                          type:TWMessageBarMessageTypeError
                                                statusBarStyle:UIStatusBarStyleLightContent
                                                      callback:nil];
}

- (void)goToMovie:(Movie *)movie {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MovieDetail" bundle:nil];
    MovieDetailViewController *viewController = (MovieDetailViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"MovieDetailViewController"];
    
    [viewController setMovieObj:movie];

    [self.navigationController pushViewController:viewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
