//
//  MRChapter.h
//  MangaReader
//
//  Created by PhucVQ1 on 3/20/15.
//  Copyright (c) 2015 petphuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRChapter : NSObject
{
    NSString *_id;
    NSString *chapName;
}
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *chapName;

@end
