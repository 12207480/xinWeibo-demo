//
//  SettingArrowItem.m
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    SettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}
@end
