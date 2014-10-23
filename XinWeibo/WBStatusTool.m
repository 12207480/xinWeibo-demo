//
//  WBStatusTool.m
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBHttpTool.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBStatus.h"
#import "MJExtension.h"
#import "WBComment.h"

@implementation WBStatusTool

+ (void)statusesDataWithSinceId:(long long)sinceId maxId:(long long)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 封装参数请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"count"] = @10;
    params[@"since_id"] = @(sinceId);
    params[@"max_id"] = @(maxId);
    
    // 发送请求
    [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
        if(success) {
            NSArray *statuses = [WBStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
           success(statuses);
        }
    } failure:^(NSError *error) {
        if(failure)
            failure(error);
    }];
    
    
}

+ (void)statusDataWithId:(long long)statusId success:(void (^)(WBStatus *))success failure:(void (^)(NSError *))failure
{
    // 封装参数请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
     params[@"id"] = @(statusId);
    
    // 发送请求
    [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/show.json" params:params success:^(id json) {
        if(success) {
            WBStatus *status = [WBStatus objectWithKeyValues:json];
            success(status);
        }
    } failure:^(NSError *error) {
        if(failure)
            failure(error);
    }];
}

+ (void)commentsDataWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 封装参数请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"count"] = @20;
    params[@"since_id"] = @(sinceId);
    params[@"max_id"] = @(maxId);
    params[@"id"] = @(statusId);
    
    // 发送请求
    [WBHttpTool getWithURL:@"https://api.weibo.com/2/comments/show.json" params:params success:^(id json) {
        if(success) {
            NSArray *commments = [WBComment objectArrayWithKeyValuesArray:json[@"comments"]];
            success(commments);
        }
    } failure:^(NSError *error) {
        if(failure)
            failure(error);
    }];

}

+ (void)repostsDataWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 封装参数请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"count"] = @15;
    params[@"since_id"] = @(sinceId);
    params[@"max_id"] = @(maxId);
    params[@"id"] = @(statusId);
    
    // 发送请求
    [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/repost_timeline.json" params:params success:^(id json) {
        if(success) {
            NSArray *statuses = [WBStatus objectArrayWithKeyValuesArray:json[@"reposts"]];
            success(statuses);
        }
    } failure:^(NSError *error) {
        if(failure)
            failure(error);
    }];

}

@end
