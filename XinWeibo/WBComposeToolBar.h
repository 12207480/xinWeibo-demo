//
//  WBComposeToolBar.h
//  XinWeibo
//
//  Created by tanyang on 14/10/17.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WBComposeToolbarButtonTypeCamera,
    WBComposeToolbarButtonTypePicture,
    WBComposeToolbarButtonTypeMention,
    WBComposeToolbarButtonTypeTrend,
    WBComposeToolbarButtonTypeEmotion
} WBComposeToolbarButtonType;

@class WBComposeToolBar;

@protocol WBComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolBar:(WBComposeToolBar *)toolbar didClickedButton:(WBComposeToolbarButtonType)buttonType;

@end

@interface WBComposeToolBar : UIView
@property (nonatomic, weak) id<WBComposeToolBarDelegate> delegate;
@end
