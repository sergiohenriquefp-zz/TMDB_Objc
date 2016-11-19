//
//  CustomButton.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIButton (CustomButton)

@property (nonatomic, copy) NSString *stringTag;

- (void)loadImageFromUrlString: (NSString *) url;
- (void)loadImageFromUrlString: (NSString *) url success:(void (^)())success;

- (void)loadBackgroundImageFromUrlString: (NSString *) url;
- (void)loadBackgroundImageFromUrlString: (NSString *) url success:(void (^)())success;

@end
