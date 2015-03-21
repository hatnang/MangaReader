//
//  MRMangaCell.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRMangaInfo.h"
#import "UIImageView+UIActivityIndicatorForSDWebImageOnImage.h" 

@interface MRMangaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageThumb;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lbChapters;
@property (weak, nonatomic) MRMangaInfo *mangaInfo;

+(float) getHeightOfCell;
- (void) reloadWithManga:(MRMangaInfo *)_manga;

@end
