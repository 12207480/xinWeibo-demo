//
//  WBAccount.h
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject<NSCoding>
// 服务器返回token
@property (nonatomic, copy) NSString *access_token;
// 用户过期时间
@property (nonatomic, strong) NSDate *expiresTime;
// token 有效时间
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
// 当前授权用户的UID
@property (nonatomic, assign) long long uid;

+ (instancetype)accountWithDic:(NSDictionary *)dic;
@end
