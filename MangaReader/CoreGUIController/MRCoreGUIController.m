//
//  MRCoreGUIController.m
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//


#import "MRCoreGUIController.h"

@implementation MRCoreGUIController

-(id) initCoreGUIController:(UIWindow *)_window
{
    self = [super init];
    window = _window;
    return self;
}

-(void) startUp
{
    navi = [[UINavigationController alloc]init];
    [window setRootViewController:navi];
    mangaVC = [[MRMangaViewController alloc]initBaseViewController:self];
    [navi pushViewController:mangaVC animated:YES];
}

- (void)fishedMangaTransitToChaptersWithId:(NSString *)mangaId
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:(UIView *)window cache:YES];
    chaptersVC = [[MRChaptersViewController alloc]initBaseViewController:self];
    chaptersVC.mangaId = mangaId;
    [navi pushViewController:chaptersVC animated:YES];
    [UIView commitAnimations];
}

- (void)fishedChapterTransitToDetailsWithId:(NSString *)chapId
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:(UIView *)window cache:YES];
    detailsVC = [[MRDetailsViewController alloc]initBaseViewController:self];
    detailsVC.chapId = chapId;
    [navi pushViewController:detailsVC animated:YES];
    [UIView commitAnimations];
}

@end
