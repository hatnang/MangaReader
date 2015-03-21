//
//  MRMangaViewController.m
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRMangaViewController.h"
#import "MRCoreGUIController.h"

// MangaFox source
#define kSourceID       @"53b2e4864c65738212010000"
#define kErrorMessage   @"Error loading Manga"

static NSString * reuseIdentifier = @"MRMangaCell";

@implementation MRMangaViewController
@synthesize dataSource, mangaArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Manga List";
    // register to use the cell
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
    [self.tbManga registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    self.dataSource = [[NSArray alloc]init];
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
    
    NSString *string = [NSString stringWithFormat:@"%@comics/top.json?source_id=%@", BaseURLString, kSourceID];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        self.dataSource = (NSArray *)responseObject;
        [self getMangaInfo:self.dataSource];
        [self.tbManga reloadData];
        
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

- (void)getMangaInfo:(NSArray *)_manga
{
    mangaArray = [[NSMutableArray alloc]init];
    [_manga enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
        MRMangaInfo *manga = [[MRMangaInfo alloc]init];
        manga._id = [obj objectForKey:@"_id"];
        manga.imgUrl = [obj objectForKey:@"thumbnail_url"];
        manga.name = [obj objectForKey:@"name"];
        manga.author = [obj objectForKey:@"author"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict = [obj objectForKey:@"newest_chapter"];
        int chap = [[dict valueForKey:@"order"] integerValue];
        manga.chapters = [NSString stringWithFormat:@"%i", chap];
        [mangaArray addObject:manga];
    } ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mangaArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRMangaCell *cell = (MRMangaCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.mangaInfo = [mangaArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MRMangaCell getHeightOfCell];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRMangaInfo *manga = [self.mangaArray objectAtIndex:indexPath.row];
    NSString *idManga = manga._id;
    [mainGUI fishedMangaTransitToChaptersWithId:idManga];
}

@end
