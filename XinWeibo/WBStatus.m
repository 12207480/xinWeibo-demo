//
//  WBStatus.m
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBStatus.h"
#import "NSDate+WB.h"
#import "MJExtension.h"
#import "WBPhoto.h"

@implementation WBStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [WBPhoto class]};
}
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

- (void)setSource:(NSString *)source
{
    int start = [source rangeOfString:@">"].location + 1;
    int length = [source rangeOfString:@"</"].location - start;
    NSString *newSource = [source substringWithRange:NSMakeRange(start, length)];
    _source = [NSString stringWithFormat:@"来自%@",newSource];
}
@end
