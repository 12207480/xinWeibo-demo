//
//  WBADImageItem.h
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "RETableViewItem.h"

@interface WBADImageItem : RETableViewItem
@property (nonatomic, copy) NSString *imageName;
+ (WBADImageItem *)itemWithImageNamed:(NSString *)imageName;
@end
