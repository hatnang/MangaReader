//
//  UIImageView+UIActivityIndicatorForSDWebImage.m
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Copyright (c) 2013 Giacomo Saccardo. All rights reserved.
//

#import "UIImageView+UIActivityIndicatorForSDWebImageOnImage.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"

static char TAG_ACTIVITY_INDICATOR_ON_IMAGE;

@interface UIImageView (Private)

-(void)createActivityIndicatorWithStyleOnImage:(UIActivityIndicatorViewStyle) activityStyle;
-(void)removeActivityIndicatorOnImage;

@end

@implementation UIImageView (UIActivityIndicatorForSDWebImageOnImage)

@dynamic activityIndicatorOnImage;

- (UIActivityIndicatorView *)activityIndicatorOnImage {
    return (UIActivityIndicatorView *)objc_getAssociatedObject(self, &TAG_ACTIVITY_INDICATOR_ON_IMAGE);
}

- (void)setActivityIndicatorOnImage:(UIActivityIndicatorView *)activityIndicator {
    objc_setAssociatedObject(self, &TAG_ACTIVITY_INDICATOR_ON_IMAGE, activityIndicator, OBJC_ASSOCIATION_RETAIN);
}



- (void)createActivityIndicatorWithStyleOnImage:(UIActivityIndicatorViewStyle) activityStyle {

    
    if ([self activityIndicatorOnImage] == nil) {
        self.activityIndicatorOnImage = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
        
        self.activityIndicatorOnImage.autoresizingMask = UIViewAutoresizingNone;
        
        //calculate the correct position
        float width = self.activityIndicatorOnImage.frame.size.width;
        float height = self.activityIndicatorOnImage.frame.size.height;
        float x = (self.frame.size.width / 2.0) - width/2;
        float y = (self.frame.size.height / 2.0) - height/2;
        self.activityIndicatorOnImage.frame = CGRectMake(x, y, width, height);
        
        self.activityIndicatorOnImage.hidesWhenStopped = YES;
        [self addSubview:self.activityIndicatorOnImage];
    }
    [self.activityIndicatorOnImage startAnimating];

}

- (void)removeActivityIndicatorOnImage {

    
    if ([self activityIndicatorOnImage]) {
        [[self activityIndicatorOnImage] removeFromSuperview];
        [self setActivityIndicatorOnImage:nil];
    }
}

- (void)removeActivityIndicatorOnImageAndResize:(CGSize)newSize {
    CGRect frame = self.frame;
    //    frame.size.height = newSize.height*86/100;
    frame.size.height = 14;
    frame.size.width  = newSize.width;
    self.frame = frame;
    
    if ([self activityIndicatorOnImage]) {
        [[self activityIndicatorOnImage] removeFromSuperview];
        [self setActivityIndicatorOnImage:nil];
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

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completedBlock:(SDWebImageCompletedBlock)completedBlock {
    
    if (url == nil) {
        return;
    }
    [self createActivityIndicatorWithStyleOnImage:UIActivityIndicatorViewStyleGray];
     __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                     [weakSelf removeActivityIndicatorOnImage];
                    completedBlock(image, error, cacheType);
                    
                }
     ];
}


- (void)setImageWithURL:(NSURL *)url usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        return;
    }
    
    [self createActivityIndicatorWithStyleOnImage:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:nil
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStye {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyleOnImage:activityStye];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle{
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyleOnImage:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        return;
    }
    
    [self createActivityIndicatorWithStyleOnImage:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyleOnImage:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

- (void)setImageAndResizeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    
    [self createActivityIndicatorWithStyleOnImage:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicatorOnImageAndResize:image.size];
                }
     ];
}
    
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }
    [self createActivityIndicatorWithStyleOnImage:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

    
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (url == nil) {
        self.image = placeholder;
        return;
    }

    [self createActivityIndicatorWithStyleOnImage:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                 progress:progressBlock
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeActivityIndicatorOnImage];
                }
     ];
}

@end
