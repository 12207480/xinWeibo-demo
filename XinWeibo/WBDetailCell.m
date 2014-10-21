//
//  WBDetailCell.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDetailCell.h"
#import "WBStatusTopView.h"
#import "WBRetweetStatusView.h"
#import "WBDetailViewController.h"
#import "WBBaseStatusframe.h"
#import "WBStatus.h"
#import "WBTabBarViewController.h"

@interface WBDetailCell()

@end
@implementation WBDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 监听被转发微博的点击
        [self.topView.retweetView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
