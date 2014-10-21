//
//  WBUser.h
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject

// 用户id
@property (nonatomic, copy) NSString *idstr;

// 用户昵称
@property (nonatomic, copy) NSString *name;

// 用户头像
@property (nonatomic, copy) NSString *profile_image_url;

// vip等级
@property (nonatomic, assign) int mbrank;

// 会员类型
@property (nonatomic, assign) int mbtype;

@end
