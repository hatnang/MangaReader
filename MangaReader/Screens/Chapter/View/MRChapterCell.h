//
//  MRChapterCell.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRChapter.h"

@interface MRChapterCell : UITableViewCell
{
    NSString *chapName;
}
@property (weak, nonatomic) IBOutlet UILabel *chapterName;
@property (nonatomic, retain) NSString *chapName;
@property (strong, nonatomic) MRChapter *chapter;

+ (float)getHeightOfCell;
@end
