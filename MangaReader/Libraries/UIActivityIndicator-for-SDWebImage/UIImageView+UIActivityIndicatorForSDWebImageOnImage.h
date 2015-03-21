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


@interface UIImageView (UIActivityIndicatorForSDWebImageOnImage)

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorOnImage;

- (void)setImageWithURL:(NSURL *)url completedBlock:(SDWebImageCompletedBlock)completedBlock;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completedBlock:(SDWebImageCompletedBlock)completedBlock;
- (void)setImageWithURL:(NSURL *)url usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageAndResizeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyleOnImage:(UIActivityIndicatorViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock;
- (void)removeActivityIndicatorOnImage;

@end
