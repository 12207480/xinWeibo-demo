//
//  SetingItem.h
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SettingItemOption)();

@interface SettingItem : NSObject
// 图标
@property (nonatomic, copy) NSString *icon;
// 标题
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) SettingItemOption option;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
