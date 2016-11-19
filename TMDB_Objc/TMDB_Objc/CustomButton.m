//
//  CustomButton.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "CustomButton.h"
#import "UIButton+AFNetworking.h"
#import <objc/runtime.h>

@implementation UIButton (sky)

static NSString *kStringTagKey = @"StringTagKey";
- (NSString *)stringTag
{
    return objc_getAssociatedObject(self, CFBridgingRetain(kStringTagKey));
}
- (void)setStringTag:(NSString *)stringTag
{
    objc_setAssociatedObject(self, CFBridgingRetain(kStringTagKey), stringTag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) loadImageFromUrlString: (NSString *) url
{
    //self.backgroundColor = [UIColor clearColor];
    if (!url || [url isEqualToString:@""]) {
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        return;
    }
    
    [self setStringTag:url];
    
    [self removeActivity];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:request];
    if (cachedImage) {
        [self setImage:cachedImage forState:UIControlStateNormal];
        return;
    }
    else{
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    __block UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiView.tag = 10;
    [aiView setColor:[UIColor grayColor]];
    [aiView startAnimating];
    [aiView setHidesWhenStopped:YES];
    [self addSubview:aiView];
    aiView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    __weak __typeof(self)wSelf = self;
    [self setImage:nil forState:UIControlStateNormal];
    [self setImageForState:UIControlStateNormal withURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        __strong __typeof(wSelf)strongSelf = wSelf;
        if ([strongSelf.stringTag isEqualToString:[request URL].absoluteString]) {
            
            if (!strongSelf)
            return;
            
            if (aiView) {
                [aiView removeFromSuperview];
            }
            
            [UIView transitionWithView:strongSelf
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [strongSelf setImage:image forState:UIControlStateNormal];
                            }
                            completion:NULL];
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (aiView) {
            [aiView removeFromSuperview];
        }
    }];
}

- (void) loadImageFromUrlString: (NSString *) url success:(void (^)())success
{
    //self.backgroundColor = [UIColor clearColor];
    if (!url || [url isEqualToString:@""]) {
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        return;
    }
    
    [self setStringTag:url];
    
    [self removeActivity];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:request];
    if (cachedImage) {
        [self setImage:cachedImage forState:UIControlStateNormal];
        success();
        return;
    }
    else{
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    
    __block UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiView.tag = 10;
    [aiView setColor:[UIColor grayColor]];
    [aiView startAnimating];
    [aiView setHidesWhenStopped:YES];
    [self addSubview:aiView];
    aiView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    __weak __typeof(self)wSelf = self;
    [self setImage:nil forState:UIControlStateNormal];
    
    [self setImageForState:UIControlStateNormal withURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        __strong __typeof(wSelf)strongSelf = wSelf;
        if ([strongSelf.stringTag isEqualToString:[request URL].absoluteString]) {
            
            if (!strongSelf)
            return;
            
            if (aiView) {
                [aiView removeFromSuperview];
            }
            
            [UIView transitionWithView:strongSelf
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [strongSelf setImage:image forState:UIControlStateNormal];
                                success();
                            }
                            completion:NULL];
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (aiView) {
            [aiView removeFromSuperview];
        }
    }];
}

- (void) loadBackgroundImageFromUrlString: (NSString *) url
{
    //self.backgroundColor = [UIColor clearColor];
    if (!url || [url isEqualToString:@""]) {
        [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        return;
    }
    
    [self setStringTag:url];
    
    [self removeActivity];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:request];
    if (cachedImage) {
        [self setBackgroundImage:cachedImage forState:UIControlStateNormal];
        return;
    }
    else{
        [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    __block UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiView.tag = 10;
    [aiView setColor:[UIColor grayColor]];
    [aiView startAnimating];
    [aiView setHidesWhenStopped:YES];
    [self addSubview:aiView];
    aiView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    __weak __typeof(self)wSelf = self;
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImageForState:UIControlStateNormal withURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        __strong __typeof(wSelf)strongSelf = wSelf;
        if ([strongSelf.stringTag isEqualToString:[request URL].absoluteString]) {
            
            if (!strongSelf)
            return;
            
            if (aiView) {
                [aiView removeFromSuperview];
            }
            
            [UIView transitionWithView:strongSelf
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [strongSelf setBackgroundImage:image forState:UIControlStateNormal];
                            }
                            completion:NULL];
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (aiView) {
            [aiView removeFromSuperview];
        }
    }];
}

- (void) loadBackgroundImageFromUrlString: (NSString *) url success:(void (^)())success
{
    //self.backgroundColor = [UIColor clearColor];
    if (!url || [url isEqualToString:@""]) {
        [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        return;
    }
    
    [self setStringTag:url];
    
    [self removeActivity];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:request];
    if (cachedImage) {
        [self setBackgroundImage:cachedImage forState:UIControlStateNormal];
        success();
        return;
    }
    else{
        [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    
    __block UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiView.tag = 10;
    [aiView setColor:[UIColor grayColor]];
    [aiView startAnimating];
    [aiView setHidesWhenStopped:YES];
    [self addSubview:aiView];
    aiView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    __weak __typeof(self)wSelf = self;
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    
    [self setBackgroundImageForState:UIControlStateNormal withURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        __strong __typeof(wSelf)strongSelf = wSelf;
        if ([strongSelf.stringTag isEqualToString:[request URL].absoluteString]) {
            
            if (!strongSelf)
            return;
            
            if (aiView) {
                [aiView removeFromSuperview];
            }
            
            [UIView transitionWithView:strongSelf
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [strongSelf setBackgroundImage:image forState:UIControlStateNormal];
                                success();
                            }
                            completion:NULL];
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (aiView) {
            [aiView removeFromSuperview];
        }
    }];
}

- (void)removeActivity{
    
    for (UIView *i in self.subviews){
        if([i isKindOfClass:[UIActivityIndicatorView class]]){
            UIActivityIndicatorView *newLbl = (UIActivityIndicatorView *)i;
            if(newLbl.tag == 10){
                /// Write your code
                [newLbl removeFromSuperview];
            }
        }
    }
}

- (void)dealloc
{
    // if MRC, call [super dealloc], too
    
    [self cancelImageRequestOperationForState:UIControlStateNormal];
}


@end
