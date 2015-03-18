//
//  WBADImageItem.m
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBADImageItem.h"

@implementation WBADImageItem
+ (WBADImageItem *)itemWithImageNamed:(NSString *)imageName
{
    WBADImageItem *item = [[WBADImageItem alloc]init];
    item.imageName = imageName;
    return item;
}
@end
