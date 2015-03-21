//
//  MRImageCell.h
//  MangaReader
//
//  Created by petphuc on 3/21/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRImageCell : UITableViewCell
{
    NSString *urlString;
    NSString *url;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
@property (nonatomic, copy) NSString *urlString;

+ (float)getHeightOfCell;

@end
