//
//  MRCoreGUIController.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRMangaViewController.h"
#import "MRChaptersViewController.h"
#import "MRDetailsViewController.h"

@interface MRCoreGUIController : NSObject
{
    // Use the window to set root view controller
    UIWindow *window;
    
    UINavigationController *navi;
    
    MRMangaViewController *mangaVC;
    MRChaptersViewController *chaptersVC;
    MRDetailsViewController *detailsVC;
}

- (id) initCoreGUIController:(UIWindow *)_window;
- (void) startUp;
- (void)fishedMangaTransitToChaptersWithId:(NSString *)mangaId;
- (void)fishedChapterTransitToDetailsWithId:(NSString *)chapId;

@end
