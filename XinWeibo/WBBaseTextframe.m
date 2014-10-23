//
//  WBBaseTextframe.m
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBBaseTextframe.h"
#import "WBBaseStatus.h"
#import "WBUser.h"

@interface WBBaseTextframe()

@end
@implementation WBBaseTextframe
/**
 *  获得微博数据后，计算微博子控件的frame
 *
 *  @param status 微博数据
 */
- (void)setStatus:(WBBaseStatus *)status
{
    _status = status;
    
    // cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * WBStatusTableBorder;
    
    
    // 头像
    CGFloat iconViewWH = 30;
    CGFloat iconViewX = 0 + WBStatusCellBorder;
    CGFloat iconViewY = 0 + WBStatusCellBorder;
    _iconViewFrame = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewFrame) + WBStatusCellBorder*0.5;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:WBStatusNameFont];
    _nameLabelFrame = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    //会员图标
    if (status.user.mbtype > 2) {
        CGFloat vipViewW = 14;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelFrame) +WBStatusCellBorder;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewY = nameLabelY;
        _vipViewFrame = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 微博内容
    CGFloat contentLabelX = nameLabelX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_nameLabelFrame), CGRectGetMaxY(_iconViewFrame)) + WBStatusTableBorder * 0.8;
    CGFloat contentLabelMaxW = cellW - WBStatusCellBorder - contentLabelX;
    CGSize contentLabelSize = [status.text sizeWithFont:WBStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelFrame = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    // 时间
    CGFloat timeX = contentLabelX;
    CGFloat timeY = CGRectGetMaxY(_contentLabelFrame) + WBStatusCellBorder;
    CGSize timeSize = CGSizeMake(contentLabelMaxW, WBStatusTimeFont.lineHeight);
    _timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
    
    // cell 高度
    _cellHeight = CGRectGetMaxY(_timeLabelFrame) + WBStatusCellBorder;
    
}
@end
