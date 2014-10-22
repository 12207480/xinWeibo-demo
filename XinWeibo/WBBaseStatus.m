//
//  WBBaseStatus.m
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBBaseStatus.h"
#import "NSDate+WB.h"

@implementation WBBaseStatus

- (NSString *)created_at
{
    // 转发微博发送的时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //真机调试下必须加
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 计算距离现在的时间
    NSString *result = [NSDate compareCurrentTime:createdDate];
    
    return  result;
}
@end
