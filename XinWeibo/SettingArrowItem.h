//
//  SettingArrowItem.h
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "SettingItem.h"

@interface SettingArrowItem : SettingItem
// 点击cell 运行的控制器
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
@end
