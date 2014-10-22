//
//  WBStatusTool.h
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusTool : NSObject
/**
 *  获取微博数据
 *
 *  @param sinceId 返回ID比since_id大的微博，默认为0
 *  @param maxId   返回ID小于或等于max_id的微博，默认为0。
 *  @param success 请求成功后的回调，传回status数组
 *  @param failure 请求失败后的回调
 */
+ (void)statusWithSinceId:(long long)sinceId maxId:(long long)maxId success:(void (^)(NSArray *status))success failure:(void(^)(NSError *error))failure;
@end
