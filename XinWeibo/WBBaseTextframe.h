//
//  WBBaseTextframe.h
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBBaseStatus;
@interface WBBaseTextframe : NSObject
{
@protected
    CGFloat _cellHeight;
    WBBaseStatus *_status;
}
@property (nonatomic, strong) WBBaseStatus *status;

// 头像
@property (nonatomic, assign, readonly) CGRect iconViewFrame;
// 会员图标
@property (nonatomic, assign, readonly) CGRect vipViewFrame;
// 昵称
@property (nonatomic, assign, readonly) CGRect nameLabelFrame;
// 时间
@property (nonatomic, assign, readonly) CGRect timeLabelFrame;
// 正文
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;

/**
 *  cell 的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
