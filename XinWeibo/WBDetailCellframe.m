//
//  WBDetailCellframe.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDetailCellframe.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBPhotosView.h"

@implementation WBDetailCellframe

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    // 设置原文微博topview内容的frame
    [self setTopViewContentFrame:status];
    
    // cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * WBStatusTableBorder;
    
    // topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    if (status.retweeted_status) {
        
        // 设置转发微博reweetView 内容的frame
        [self setRetweetViewContentFrame:status];
        
        // 有转发微博
        topViewH = CGRectGetMaxY(_retweetViewFrame) ;
    } else{ // 没有转发微博
        if (status.pic_urls.count) { // 有图
            topViewH = CGRectGetMaxY(self.photoViewFrame);
        } else {
            topViewH = CGRectGetMaxY(self.contentLabelFrame);
        }
    }
    
    // topview 高度
    topViewH += WBStatusCellBorder;
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    
    // 计算cell 的 高度
    _cellHeight = CGRectGetMaxY(_topViewFrame) + WBStatusTableBorder;
}

- (void)setRetweetViewContentFrame:(WBStatus *)status
{
    [super setRetweetViewContentFrame:status];
    
//    frame.size.width = 200;
//    frame.size.height = kRetweetedDockHeight;
    
    CGFloat retweetToolbarW = 200;
    CGFloat retweetToolbarH = RetweetedToolBarHeight;
    CGFloat retweetToolbarX = _retweetViewFrame.size.width - retweetToolbarW - 2;
    CGFloat retweetToolbarY = _retweetViewFrame.size.height + WBStatusCellBorder - 2;
    
    _retweetToolBarFrame = CGRectMake(retweetToolbarX, retweetToolbarY, retweetToolbarW, retweetToolbarH);
    _retweetViewFrame.size.height += retweetToolbarH + WBStatusCellBorder;
    
}
@end
