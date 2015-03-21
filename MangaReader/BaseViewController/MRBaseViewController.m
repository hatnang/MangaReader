//
//  MRBaseViewController.m
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRBaseViewController.h"

@interface MRBaseViewController ()

@end

@implementation MRBaseViewController

-(id) initBaseViewController:(MRCoreGUIController *)_mainGUI
{
    self = [super init];
    mainGUI = _mainGUI;
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
}
@end
