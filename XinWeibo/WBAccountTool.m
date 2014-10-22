//
//  WBAccountTool.m
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBHttpTool.h"

@implementation WBAccountTool

+ (NSString *)accountFilePath
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *saveFile = [doc stringByAppendingPathComponent:@"account.data"];
    return saveFile;
}

// 保存账号信息
+ (void)saveAccount:(WBAccount *)account
{
    NSDate *curData = [NSDate date];
    account.expiresTime = [curData dateByAddingTimeInterval:account.expires_in];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:[self accountFilePath]];
}

// 获取账号信息
+ (WBAccount *)account
{
    //取出账号
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[self accountFilePath]];
    NSDate *curData = [NSDate date];
    // 比较是否过期
    if ([curData compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    }else {
        return nil;
    }
}

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = WBAppKey;
    params[@"client_secret"] = WBAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = WBRedirectUrl;
    
    // 发生请求
    [WBHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        //WBLog(@"accessToken请求成功：%@",json);
        // 将字典转位模型
        WBAccount *account = [WBAccount accountWithDic:json];
        
        // 归档
        [WBAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
