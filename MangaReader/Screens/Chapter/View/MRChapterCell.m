//
//  MRChapterCell.m
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRChapterCell.h"

@implementation MRChapterCell
@synthesize chapName;

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)resetView
{
    self.chapterName.text = @"";
}

- (void)setChapter:(MRChapter *)chapter
{
    _chapter = chapter;
    [self reloadChapter:_chapter];
}

- (void)reloadChapter:(MRChapter *)_chap
{
    self.chapterName.text = _chap.chapName;
}

+ (float)getHeightOfCell
{
    return 50;
}


@end
