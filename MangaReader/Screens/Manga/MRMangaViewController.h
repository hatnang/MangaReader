//
//  MRMangaViewController.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRBaseViewController.h"
#import "MRMangaCell.h"

@interface MRMangaViewController : MRBaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *dataSource;
    NSMutableArray *mangaArray;
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UITableView *tbManga;
@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, retain) NSMutableArray *mangaArray;


@end
