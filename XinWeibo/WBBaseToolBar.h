//
//  WBBaseToolBar.h
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBBaseToolBar : UIImageView

/**
 *  初始化分割线
 */
- (void)setupDivider;

/**
 *  创建按钮
 *
 *  @param title   按钮标题
 *  @param image   按钮图片
 *  @param bgImage 按钮背景图片
 *
 *  @return 按钮
 */
- (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString  *)bgImage;

@end
