//
//  WBUserTool.h
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUser;
@interface WBUserTool : NSObject
/**
 *  获取用户数据
 *
 *  @param success 请求成功后的回调，传回user数组
 *  @param failure 请求失败后的回调
 */
+ (void)userDataWithSuccess:(void (^)(WBUser *user))success failure:(void(^)(NSError *error))failure;
@end
