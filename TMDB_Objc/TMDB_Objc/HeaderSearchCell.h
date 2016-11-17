//
//  HeaderSearchCell.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderSearchCellDelegate <NSObject>

@optional

- (void)searchWithText:(NSString *)text;

@end

@interface HeaderSearchCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) id <HeaderSearchCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *tfSearch;
@property (strong, nonatomic) IBOutlet UIButton *btClear;

- (void)populate;
- (IBAction)clearClicked:(id)sender;

@end

