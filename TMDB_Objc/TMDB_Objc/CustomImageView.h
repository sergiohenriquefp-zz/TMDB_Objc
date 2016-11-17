//
//  CustomImageView.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImageView (CustomImageView)

@property (nonatomic, copy) NSString *stringTag;

- (void) loadImageFromUrlString: (NSString *) url;
- (void) loadImageFromUrlString: (NSString *) url success:(void (^)())success;

@end
