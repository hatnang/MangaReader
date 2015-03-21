//
//  MRMangaCell.m
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRMangaCell.h"

@implementation MRMangaCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float) getHeightOfCell
{
    return 200;
}

- (void)setMangaInfo:(MRMangaInfo *)mangaInfo
{
    _mangaInfo = mangaInfo;
    [self reloadWithManga:_mangaInfo];
}

- (void)resetView
{
    self.lbAuthor.text = @"";
    self.lbChapters.text = @"";
    self.lbName.text = @"";
}

- (void)reloadWithManga:(MRMangaInfo *)_manga
{
    [self resetView];
    [self.imageThumb setImageWithURL:[NSURL URLWithString:_manga.imgUrl]
                      placeholderImage:[UIImage imageNamed:@"pic_thumb_noimage"]
    usingActivityIndicatorStyleOnImage:UIActivityIndicatorViewStyleGray];
    self.lbName.text = _manga.name;
    self.lbAuthor.text = _manga.author;
    self.lbChapters.text = _manga.chapters;
}

@end
