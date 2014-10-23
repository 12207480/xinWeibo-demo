//
//  SetingItem.m
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    SettingItem *item = [[self alloc]init];
    item.icon = icon;
    item.title = title;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    SettingItem *item = [[self alloc]init];
    item.title = title;
    return item;
}

@end
