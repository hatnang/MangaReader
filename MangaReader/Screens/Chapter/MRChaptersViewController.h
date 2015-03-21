//
//  MRChaptersViewController.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRBaseViewController.h"
#import "MRChapterCell.h"
#import "MRChapter.h"

@interface MRChaptersViewController : MRBaseViewController
{
    NSString *mangaId;
    NSArray *dataSource;
    MBProgressHUD *hud;
    NSMutableArray *chapterArray;
}
@property (nonatomic, copy) NSString *mangaId;
@property (weak, nonatomic) IBOutlet UITableView *tbChapters;
@property (nonatomic, retain) NSArray *dataSource;


@end
