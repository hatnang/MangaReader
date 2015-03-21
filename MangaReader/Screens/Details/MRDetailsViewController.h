//
//  MRDetailsViewController.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRBaseViewController.h"
#import "MRImageCell.h"

@interface MRDetailsViewController : MRBaseViewController
{
    NSString *chapId;
    NSArray *urlsImage;
    MBProgressHUD *hud;
    NSMutableArray *imagesArray;
}
@property (nonatomic, copy) NSString *chapId;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (weak, nonatomic) IBOutlet UITableView *tbDetails;

@end
