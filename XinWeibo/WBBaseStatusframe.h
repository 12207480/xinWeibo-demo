//
//  WBBaseStatusframe.h
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatus;
@interface WBBaseStatusframe : NSObject
{
    @protected
    CGFloat _cellHeight;
    CGRect _retweetViewFrame;
    
}
@property (nonatomic, strong) WBStatus *status;

// 顶部的view
@property (nonatomic, assign, readonly) CGRect topViewFrame;
// 头像
@property (nonatomic, assign, readonly) CGRect iconViewFrame;
// 会员图标
@property (nonatomic, assign, readonly) CGRect vipViewFrame;
// 配图
@property (nonatomic, assign, readonly) CGRect photoViewFrame;
// 昵称
@property (nonatomic, assign, readonly) CGRect nameLabelFrame;
// 时间
@property (nonatomic, assign, readonly) CGRect timeLabelFrame;
// 来源
@property (nonatomic, assign, readonly) CGRect sourceLabelFrame;
// 正文
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;

// 被转发微博的view
@property (nonatomic, assign, readonly) CGRect retweetViewFrame;
// 被转发微博的昵称
@property (nonatomic, assign, readonly) CGRect retweetNameLabelFrame;
// 被转发微博的正文
@property (nonatomic, assign, readonly) CGRect retweetContentLabelFrame;
// 被转发微博的配图
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewFrame;

/**
 *  cell 的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
