//
//  MRMangaInfo.h
//  MangaReader
//
//  Created by petphuc on 3/18/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRMangaInfo : NSObject
{
    NSString *_id;
    NSString *imgUrl;
    NSString *name;
    NSString *author;
    NSString *chapters;
}

@property(nonatomic, retain) NSString *_id;
@property(nonatomic, retain) NSString *imgUrl;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *author;
@property(nonatomic, retain) NSString *chapters;

@end
