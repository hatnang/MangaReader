//
//  MRImageCell.m
//  MangaReader
//
//  Created by petphuc on 3/21/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRImageCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImageOnImage.h"

@implementation MRImageCell
@synthesize urlString;

- (void)awakeFromNib
{

}

-(void)setUrlString:(NSString *)_urlString
{
    url = _urlString;
    [self reloadData];
}

- (void)reloadData
{
    [self.imageDetail setImageWithURL:[NSURL URLWithString:url]
                     placeholderImage:[UIImage imageNamed:@"pic_thumb_noimage"]
   usingActivityIndicatorStyleOnImage:UIActivityIndicatorViewStyleGray];
    NSLog(@"====LINK: %@", self.urlString);
}

+ (float)getHeightOfCell
{
    return  560;
}

@end
