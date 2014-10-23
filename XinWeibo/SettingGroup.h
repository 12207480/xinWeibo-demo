//
//  SettingGroup.h
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject
// 头部标题
@property (nonatomic, copy) NSString *header;
// 尾部标题
@property (nonatomic, copy) NSString *footer;
// 存放settingitem的数组
@property (nonatomic, copy) NSArray *items;


@end
