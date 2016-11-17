//
//  GeneralViewController.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface GeneralViewController : UIViewController

- (BOOL)connected;
- (void)callSuccessMessageWithText:(NSString *)text detail:(NSString *)detail;
- (void)callInfoMessageWithText:(NSString *)text detail:(NSString *)detail;
- (void)callErrorMessageWithText:(NSString *)text detail:(NSString *)detail;
- (void)goToMovie:(Movie *)movie;

@end
