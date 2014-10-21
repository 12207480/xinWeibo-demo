//
//  WBBaseStatusCell.h
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBBaseStatusframe;
@class WBStatusTopView;
@interface WBBaseStatusCell : UITableViewCell
@property (nonatomic, strong) WBBaseStatusframe *statusFrame;
// 顶部的view
@property (nonatomic, weak) WBStatusTopView *topView;

@end
