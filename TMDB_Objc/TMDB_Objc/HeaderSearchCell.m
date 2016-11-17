//
//  HeaderSearchCell.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "HeaderSearchCell.h"

@implementation HeaderSearchCell

@synthesize tfSearch = _tfSearch;
@synthesize btClear = _btClear;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)populate{
    [self.tfSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.btClear setHidden:YES];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    if ([theTextField.text isEqualToString:@""]) {
        [self.btClear setHidden:YES];
    }
    else{
        [self.btClear setHidden:NO];
    }
    
    [self.delegate searchWithText:theTextField.text];
}

- (IBAction)clearClicked:(id)sender {
    [self.tfSearch setText:@""];
    [self.btClear setHidden:YES];
    [self.delegate searchWithText:self.tfSearch.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return NO;
}

@end
