//
//  WBStatus.m
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBStatus.h"
#import "MJExtension.h"
#import "WBPhoto.h"

@implementation WBStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [WBPhoto class]};
}

- (void)setSource:(NSString *)source
{
    int start = [source rangeOfString:@">"].location + 1;
    int length = [source rangeOfString:@"</"].location - start;
    NSString *newSource = [source substringWithRange:NSMakeRange(start, length)];
    _source = [NSString stringWithFormat:@"来自%@",newSource];
}
@end
