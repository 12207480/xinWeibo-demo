//
//  WBAccountTool.m
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"

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
@end
