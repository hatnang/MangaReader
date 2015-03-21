//
//  UIImageView+UIActivityIndicatorForSDWebImage.m
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Copyright (c) 2013 Giacomo Saccardo. All rights reserved.
//

#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"

static char TAG_ACTIVITY_INDICATOR;
static NSMutableArray *loadingImageViews;

@interface UIImageView (Private)

-(void)createActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle) activityStyle;
-(void)removeActivityIndicator;

@end

@implementation UIImageView (UIActivityIndicatorForSDWebImage)

@dynamic activityIndicator;

- (UIActivityIndicatorView *)activityIndicator {
    return (UIActivityIndicatorView *)objc_getAssociatedObject(self, &TAG_ACTIVITY_INDICATOR);
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator {
    objc_setAssociatedObject(self, &TAG_ACTIVITY_INDICATOR, activityIndicator, OBJC_ASSOCIATION_RETAIN);
}

#ifdef ON_SCREEN_LOADING_INDICATOR_ON
+ (void)removeAllLoadingIndicator {
    [loadingImageViews removeAllObjects];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}
#endif

- (void)createActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle) activityStyle {
#ifdef ON_SCREEN_LOADING_INDICATOR_ON
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window && ![MBProgressHUD HUDForView:window]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
        hud.labelText = @"Loading...";
        hud.taskInProgress = YES;
        hud.graceTime = 0.1;
        hud.userInteractionEnabled = NO;
        [window addSubview:hud];
        [hud show:YES];
    }
    if (!loadingImageViews)
        loadingImageViews = [[NSMutableArray alloc] init];
    [loadingImageViews addObject:self];
#endif
    
    if ([self activityIndicator] == nil) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
        
        self.activityIndicator.autoresizingMask = UIViewAutoresizingNone;
        
        //calculate the correct position
        float width = self.activityIndicator.frame.size.width;
        float height = self.activityIndicator.frame.size.height;
        float x = (self.frame.size.width / 2.0) - width/2;
        float y = (self.frame.size.height / 2.0) - height/2;
        self.activityIndicator.frame = CGRectMake(x, y, width, height);
        
        self.activityIndicator.hidesWhenStopped = YES;
        [self addSubview:self.activityIndicator];
    }
#ifdef IMAGE_LOADING_INDICATOR_ON
    [self.activityIndicator startAnimating];
#endif
}

- (void)removeActivityIndicator {
#ifdef ON_SCREEN_LOADING_INDICATOR_ON
    [loadingImageViews removeObject:self];
    for (id object in loadingImageViews) {
        if (object == nil) {
            [loadingImageViews removeObject:object];
        }
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window && loadingImageViews.count <= 0) {
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
    }
#endif
    
    if ([self activityIndicator]) {
        [[self activityIndicator] removeFromSuperview];
    }
}

- (void)removeActivityIndicatorAndResize:(CGSize)newSize {
    CGRect frame = self.frame;
    //    frame.size.height = newSize.height*86/100;
    frame.size.height = 14;
    frame.size.width  = newSize.width;
    self.frame = frame;
#ifdef ON_SCREEN_LOADING_INDICATOR_ON
    [loadingImageViews removeObject:self];
    for (id object in loadingImageViews) {
        if (object == nil) {
            [loadingImageViews removeObject:object];
        }
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window && loadingImageViews.count <= 0) {
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
    }
#endif
    
    if ([self activityIndicator]) {
        [[self activityIndicator] removeFromSuperview];
    }

}

#pragma mark - Methods
- (void)setImageWithURL:(NSURL *)url completedBlock:(SDWebImageCompletedBlock)completedBlock{
 
    if (url == nil) {
        return;
    }
    [self setImageWithURL:url
         placeholderImage:nil
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        return;
    }
    
    [self createActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:nil
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeActivityIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStye {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyle:activityStye];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeActivityIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle{
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeActivityIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        return;
    }
    
    [self createActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicator];
                }
     ];
}

- (void)setImageAndResizeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicatorAndResize:image.size];
                }
     ];
}
    
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    [self createActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicator];
                }
     ];
}

    
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }

    [self createActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                 progress:progressBlock
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicator];
                }
     ];
}

@end
