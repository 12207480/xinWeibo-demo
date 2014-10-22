//
//  WBBaseStatus.h
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUser;
@interface WBBaseStatus : NSObject
// 微博内容文字
@property (nonatomic, copy) NSString *text;

// 微博时间
@property (nonatomic, copy) NSString *created_at;

// 微博id
@property (nonatomic, copy) NSString *idstr;

// 微博用户
@property (nonatomic, strong) WBUser *user;
@end
