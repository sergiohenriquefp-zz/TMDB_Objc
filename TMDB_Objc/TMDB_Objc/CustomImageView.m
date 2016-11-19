//
//  CustomImageView.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "CustomImageView.h"
#import "UIImageView+AFNetworking.h"
#import <objc/runtime.h>

@implementation UIImageView (sky)

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
    self.backgroundColor = [UIColor clearColor];
    if (!url || [url isEqualToString:@""]) {
        self.image = [UIImage imageNamed:@""];
        return;
    }
    
    [self setStringTag:url];
    
    [self removeActivity];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:request];
    if (cachedImage) {
        self.image = cachedImage;
        return;
    }
    else{
        self.image = [UIImage imageNamed:@""];
    }
    
    
    __block UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiView.tag = 10;
    [aiView setColor:[UIColor grayColor]];
    [aiView startAnimating];
    [aiView setHidesWhenStopped:YES];
    [self addSubview:aiView];
    aiView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    __weak __typeof(self)wSelf = self;
    self.image = nil;
    
    [self setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
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
                                strongSelf.image = image;
                            }
                            completion:NULL];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        if (aiView) {
            [aiView removeFromSuperview];
        }
    }];
}

- (void) loadImageFromUrlString: (NSString *) url success:(void (^)())success
{
    self.backgroundColor = [UIColor clearColor];
    if (!url || [url isEqualToString:@""]) {
        self.image = [UIImage imageNamed:@""];
        return;
    }
    
    [self setStringTag:url];
    
    [self removeActivity];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:request];
    if (cachedImage) {
        self.image = cachedImage;
        success();
        return;
    }
    else{
        self.image = [UIImage imageNamed:@""];
    }
    
    
    __block UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiView.tag = 10;
    [aiView setColor:[UIColor grayColor]];
    [aiView startAnimating];
    [aiView setHidesWhenStopped:YES];
    [self addSubview:aiView];
    aiView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    __weak __typeof(self)wSelf = self;
    self.image = nil;
    [self setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
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
                                strongSelf.image = image;
                                success();
                            }
                            completion:NULL];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
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
    
    [self cancelImageRequestOperation];
}


@end
