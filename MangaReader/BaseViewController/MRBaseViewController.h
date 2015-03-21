//
//  MRBaseViewController.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD.h"

static NSString * const BaseURLString = @"http://mangayou.com/";

@class MRCoreGUIController;

@interface MRBaseViewController : UIViewController
{
    MRCoreGUIController *mainGUI;
}

-(id) initBaseViewController:(MRCoreGUIController *)_mainGUI;

@end
