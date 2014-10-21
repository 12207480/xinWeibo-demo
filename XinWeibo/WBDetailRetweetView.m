//
//  WBDetailRetweetView.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDetailRetweetView.h"
#import "WBStatusToolBar.h"
#import "WBDetailCellframe.h"
#import "WBTabBarViewController.h"
#import "WBDetailViewController.h"
#import "WBStatus.h"

@interface WBDetailRetweetView()
@property (nonatomic, weak) WBStatusToolBar *detailToolbar;
@property (nonatomic, strong) WBDetailCellframe *statusFrame;
@end
@implementation WBDetailRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加 toolbar
        WBStatusToolBar *toolbar = [[WBStatusToolBar alloc]init];
        [self addSubview:toolbar];
        self.detailToolbar = toolbar;
        
        // 监听被转发微博的点击
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
    }

    return self;
}

- (void)showRetweeted
{
    // 展示被转发的微博
    WBDetailViewController *detail = [[WBDetailViewController alloc] init];
    detail.status = self.statusFrame.status.retweeted_status;
    
    WBTabBarViewController *main = (WBTabBarViewController *)self.window.rootViewController;
    UINavigationController *nav =  (UINavigationController *)main.selectedViewController;
    
    [nav pushViewController:detail animated:YES];
}

- (void)setStatusFrame:(WBDetailCellframe *)statusFrame
{
    [super setStatusFrame:statusFrame];
    
    // toolbar
    self.detailToolbar.frame = statusFrame.retweetToolBarFrame;
    self.detailToolbar.status = statusFrame.status.retweeted_status;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
