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
#import "WBDetailCellframe.h"
#import "WBStatus.h"
#import "WBDetailTopView.h"


@interface WBDetailCell()
@property (nonatomic, strong) WBDetailCellframe *statusFrame;
@end
@implementation WBDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.topView removeFromSuperview];
        // 选中cell 的背景
        self.selectedBackgroundView = [[UIView alloc]init];
        self.backgroundColor = [UIColor clearColor];
        
        // 添加顶部view
        WBDetailTopView *topView = [[WBDetailTopView alloc]init];
        [self.contentView addSubview:topView];
        self.topView = topView;

    }
    return self;
}

- (void)setStatusFrame:(WBDetailCellframe *)statusFrame
{
    [super setStatusFrame:statusFrame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
