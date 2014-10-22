//
//  WBUserTool.m
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBUserTool.h"
#import "WBUser.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"

@implementation WBUserTool
+ (void)userDataWithSuccess:(void (^)(WBUser *))success failure:(void (^)(NSError *))failure
{
    // 封装参数请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"uid"] = @([WBAccountTool account].uid);
    
    // 发送请求
    [WBHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        //WBLog(@"加载home_timeline成功：%@",json);
        // 将字典数组转为模型数组
        WBUser *user = [WBUser objectWithKeyValues:json];
        
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
