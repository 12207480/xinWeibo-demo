//
//  WBStatusframe.m
//  XinWeibo
//
//  Created by tanyang on 14-10-13.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBStatusframe.h"
#import "WBStatus.h"
#import "WBPhotosView.h"

@implementation WBStatusframe

/**
 *  获得微博数据后，计算微博子控件的frame
 *
 *  @param status 微博数据
 */
- (void)setStatus:(WBStatus *)status
{
    [super setStatus:status];
    
    // 工具条
    CGFloat statusToolBarX = self.topViewFrame.origin.x;
    CGFloat statusToolBarY = CGRectGetMaxY(self.topViewFrame);
    CGFloat statusToolBarW = self.topViewFrame.size.width;
    CGFloat statusToolBarH = 36;
    _statusToolBarFrame = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    // 计算cell 的 高度
    _cellHeight = CGRectGetMaxY(_statusToolBarFrame) + WBStatusTableBorder;
}
@end
