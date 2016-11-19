//
//  LoadingTableViewCell.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
