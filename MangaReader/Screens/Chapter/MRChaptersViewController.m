//
//  MRChaptersViewController.m
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRChaptersViewController.h"
#import "MRCoreGUIController.h"

#define kErrorMessage       @"Error loading Chapters"

static NSString * reuseIdentifier = @"MRChapterCell";

@implementation MRChaptersViewController
@synthesize mangaId, dataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Chapters";
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
    [self.tbChapters registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    self.dataSource = [[NSArray alloc]init];
    NSLog(@"manga id: %@", self.mangaId);
    [self requestData];
}

- (void)requestData
{
    if (!hud) {
        hud=[[MBProgressHUD alloc] initWithView:self.view];
        [hud setLabelText:@"Loading..."];
        [self.view addSubview:hud];
    }
    [hud show:YES];
    
    NSString *string = [NSString stringWithFormat:@"%@chapters.json?comic_id=%@", BaseURLString, self.mangaId];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        self.dataSource = (NSArray *)responseObject;
        NSArray* reversedData = [[self.dataSource  reverseObjectEnumerator] allObjects];
        [self getChapter:reversedData];
        [self.tbChapters reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kErrorMessage
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [operation start];
}

- (void)getChapter:(NSArray *)_chap
{
    chapterArray = [[NSMutableArray alloc]init];
    [_chap enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
        MRChapter *chapter = [[MRChapter alloc]init];
        chapter._id = [obj objectForKey:@"_id"];
        chapter.chapName = [obj objectForKey:@"name"];

        [chapterArray addObject:chapter];
    } ];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chapterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRChapterCell *cell = (MRChapterCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.chapter = [chapterArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MRChapterCell getHeightOfCell];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRChapter *chap = [chapterArray objectAtIndex:indexPath.row];
    NSString *idChap = chap._id;
    [mainGUI fishedChapterTransitToDetailsWithId:idChap];
}



@end
