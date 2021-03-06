//
//  WBBaseStatusframe.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBBaseStatusframe.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBPhotosView.h"

@implementation WBBaseStatusframe
/**
 *  获得微博数据后，计算微博子控件的frame
 *
 *  @param status 微博数据
 */
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
            topViewH = CGRectGetMaxY(_photoViewFrame);
        } else {
            topViewH = CGRectGetMaxY(_contentLabelFrame);
        }
    }
    
    // topview 高度
    topViewH += WBStatusCellBorder;
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    
    // 计算cell 的 高度
    _cellHeight = CGRectGetMaxY(_topViewFrame) + WBStatusTableBorder;
}

/**
 *  设置原文微博topview内容的frame
 */
- (void)setTopViewContentFrame:(WBStatus *)status
{
    // cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * WBStatusTableBorder;
    
    // topView
    CGFloat topViewW = cellW;
    
    // 头像
    CGFloat iconViewWH = 35;
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
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelFrame), CGRectGetMaxY(_iconViewFrame)) + WBStatusTableBorder * 0.8;
    CGFloat contentLabelMaxW = topViewW - 2 * WBStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:WBStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelFrame = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    // 配图
    if (status.pic_urls.count) {
        CGSize photoViewSize = [WBPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelFrame) + WBStatusCellBorder;
        _photoViewFrame = CGRectMake(photoViewX, photoViewY, photoViewSize.width, photoViewSize.height);
    }
}

/**
 *  设置转发微博reweetView 内容的frame
 */
- (void)setRetweetViewContentFrame:(WBStatus *)status
{
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * WBStatusTableBorder;
    // 被转发微博
    CGFloat retweetViewW = cellW - 2 * WBStatusCellBorder;
    CGFloat retweetViewX = 0 + WBStatusCellBorder;
    CGFloat retweetViewY = CGRectGetMaxY(_contentLabelFrame) + WBStatusCellBorder * 0.5;
    CGFloat retweetViewH = 0;
    
    // 被转发微博昵称
    CGFloat retweetNameLabelX = WBStatusCellBorder;
    CGFloat retweetNameLabelY = WBStatusCellBorder;
    NSString *name = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
    CGSize retweetNameLabelSize = [name sizeWithFont:WBStatusRetweetNameFont];
    _retweetNameLabelFrame = (CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
    
    // 被转发微博正文
    CGFloat retweetContentLabelX = retweetNameLabelX;
    CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelFrame) + WBStatusCellBorder;
    CGFloat retweetContentLabelMaxW = retweetViewW - 2 * WBStatusCellBorder;
    CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:WBStatusRetweetContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
    _retweetContentLabelFrame = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
    
    if (status.retweeted_status.pic_urls.count) {
        //被转发微博配图
        CGSize retweetPhotoSize = [WBPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
        CGFloat retweetPhotoViewX = retweetContentLabelX;
        CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelFrame) + WBStatusCellBorder;
        _retweetPhotoViewFrame = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoSize.width, retweetPhotoSize.height);
        retweetViewH = CGRectGetMaxY(_retweetPhotoViewFrame);
    } else {
        retweetViewH = CGRectGetMaxY(_retweetContentLabelFrame);
    }
    retweetViewH += WBStatusCellBorder;
    _retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);

}

@end
