//
//  WBStatusTopView.h
//  XinWeibo
//
//  Created by tanyang on 14-10-14.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBBaseStatusframe;
@class WBRetweetStatusView;
@interface WBStatusTopView : UIImageView
@property (nonatomic, strong) WBBaseStatusframe *statusFrame;
// 被转发微博的view
@property (nonatomic, weak) WBRetweetStatusView *retweetView;
@end
