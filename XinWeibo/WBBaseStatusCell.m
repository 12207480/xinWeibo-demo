//
//  WBBaseStatusCell.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBBaseStatusCell.h"
#import "WBStatus.h"
#import "WBBaseStatusframe.h"
#import "WBStatusTopView.h"

@interface WBBaseStatusCell()

@end
@implementation WBBaseStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // 添加原创微博内部子控件
        //self.contentView.backgroundColor = [UIColor clearColor];
        [self setupTopView];

    }
    return self;
}

/**
 *  设置frame 的位置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += WBStatusTableBorder;
    frame.origin.x = WBStatusTableBorder;
    frame.size.width -= 2 * WBStatusTableBorder;
    frame.size.height -= WBStatusTableBorder;
    [super setFrame:frame];
}

/**
 * 添加原创微博内部子控件
 */
- (void)setupTopView
{
    // 选中cell 的背景
    self.selectedBackgroundView = [[UIView alloc]init];
    self.backgroundColor = [UIColor clearColor];
    
    // 添加顶部view
    WBStatusTopView *topView = [[WBStatusTopView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(WBBaseStatusframe *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 微博数据
    [self setupTopViewData];

}

/**
 *  传递原创微博数据
 */
- (void)setupTopViewData
{
    // 设置topview frame
    self.topView.frame = self.statusFrame.topViewFrame;
    
    // 设置topview数据
    self.topView.statusFrame = self.statusFrame;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
