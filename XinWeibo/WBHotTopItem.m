//
//  WBHotTopItem.m
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBHotTopItem.h"

@implementation WBHotTopItem

- (instancetype)init
{
    if (self = [super init]) {
        self.btnTiltles = [NSMutableArray array];
        self.btnImages = [NSMutableArray array];
    }
    return self;
}

- (void)setBtnsTitle:(NSString *)title
{
    [self.btnTiltles addObject:title];
    [self.btnImages addObject:@""];
}
- (void)setBtnsTitle:(NSString *)title btnsImage:(NSString *)image
{
    [self.btnTiltles addObject:title];
    [self.btnImages addObject:image];
}
@end
