//
//  WBStatus.h
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUser;
@interface WBStatus : NSObject

// 微博内容文字
@property (nonatomic, copy) NSString *text;

// 微博时间
@property (nonatomic, copy) NSString *created_at;

// 微博来源
@property (nonatomic, copy) NSString *source;

// 微博id
@property (nonatomic, copy) NSString *idstr;

// 微博配图地址
@property (nonatomic, strong) NSArray *pic_urls;

// 微博转发数
@property (nonatomic, assign) int reposts_count;

// 微博评论数
@property (nonatomic, assign) int comments_count;

// 微博被赞数
@property (nonatomic, assign) int attitudes_count;

// 微博用户
@property (nonatomic, strong) WBUser *user;

// 微博单张配图
//@property (nonatomic, copy) NSString *thumbnail_pic;

// 被转发的微博
@property (nonatomic, strong) WBStatus *retweeted_status;

@end
