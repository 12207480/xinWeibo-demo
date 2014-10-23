//
//  WBStatusTool.h
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatus;
@interface WBStatusTool : NSObject
/**
 *  获取微博数据
 *
 *  @param sinceId 返回ID比since_id大的微博，默认为0
 *  @param maxId   返回ID小于或等于max_id的微博，默认为0。
 *  @param success 请求成功后的回调，传回status数组
 *  @param failure 请求失败后的回调
 */
+ (void)statusesDataWithSinceId:(long long)sinceId maxId:(long long)maxId success:(void (^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

/**
 *  获取某一条微博数据
 *
 *  @param statusId 返回该ID的微博
 *  @param success 请求成功后的回调，传回status
 *  @param failure 请求失败后的回调
 */
+ (void)statusDataWithId:(long long)statusId success:(void (^)(WBStatus *status))success failure:(void(^)(NSError *error))failure;

/**
 *  获取某条微博评论
 *
 *  @param sinceId 返回ID比since_id大的微博，默认为0
 *  @param maxId   返回ID小于或等于max_id的微博，默认为0
 *  @param statusId 微博ID
 *  @param success 请求成功后的回调，传回comments数组
 *  @param failure 请求失败后的回调
 */
+ (void)commentsDataWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(void (^)(NSArray *comments))success failure:(void(^)(NSError *error))failure;

/**
 *  获取某条微博转发
 *
 *  @param sinceId 返回ID比since_id大的微博，默认为0
 *  @param maxId   返回ID小于或等于max_id的微博，默认为0
 *  @param statusId 微博ID
 *  @param success 请求成功后的回调，传回reports数组
 *  @param failure 请求失败后的回调
 */
+ (void)repostsDataWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(void (^)(NSArray *reports))success failure:(void(^)(NSError *error))failure;
@end
