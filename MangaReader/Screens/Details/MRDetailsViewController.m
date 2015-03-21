//
//  MRDetailsViewController.m
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import "MRDetailsViewController.h"



#define kErrorMessage       @"Error loading Details"

static NSString * reuseIdentifier = @"MRImageCell";

@implementation MRDetailsViewController
@synthesize chapId, imagesArray;

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
    self.title = @"Details";
    urlsImage = [[NSArray alloc]init];
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
    [self.tbDetails registerNib:nib forCellReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
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
    
    NSString *string = [NSString stringWithFormat:@"%@chapters/%@.json", BaseURLString, self.chapId];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        NSDictionary *dict = (NSDictionary *)responseObject;
        urlsImage = [dict objectForKey:@"pages"];
        [self.tbDetails reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [urlsImage count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRImageCell *cell = (MRImageCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.urlString = [urlsImage objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MRImageCell getHeightOfCell];
}



@end
