//
//  UIImageView+UIActivityIndicatorForSDWebImage.h
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Copyright (c) 2013 Giacomo Saccardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

// uncomment this code if you want to display indicator in each image
#define IMAGE_LOADING_INDICATOR_ON          1

// comment this code if you want to not display indicator in status bar when image is loading
//#define ON_SCREEN_LOADING_INDICATOR_ON     1

@interface UIImageView (UIActivityIndicatorForSDWebImage)

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)setImageWithURL:(NSURL *)url completedBlock:(SDWebImageCompletedBlock)completedBlock;
- (void)setImageWithURL:(NSURL *)url usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageAndResizeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
- (void)removeActivityIndicator;

#ifdef ON_SCREEN_LOADING_INDICATOR_ON
+ (void)removeAllLoadingIndicator;
#endif

@end
