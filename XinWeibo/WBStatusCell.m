//
//  WBStatuseCell.m
//  XinWeibo
//
//  Created by tanyang on 14-10-13.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatusframe.h"
#import "WBStatus.h"
#import "WBStatusToolBar.h"

@interface WBStatusCell()

@property (nonatomic, strong) WBStatusframe *statusFrame;

// 微博工具条
@property (nonatomic, weak) WBStatusToolBar *statusToolBar;

@end
@implementation WBStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // 添加微博工具条
        [self setupStatusToolBar];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"statusCell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WBStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 * 添加微博工具条
 */
- (void)setupStatusToolBar
{
    // 微博工具条
    WBStatusToolBar *statusToolBar = [[WBStatusToolBar alloc]init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;

}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(WBStatusframe *)statusFrame
{
    [super setStatusFrame:statusFrame];
    
    // 微博工具条
    [self setupStatusToolBarData];
}

- (void)setupStatusToolBarData
{
    // 设置ToolBar frame
    self.statusToolBar.frame = self.statusFrame.statusToolBarFrame;
    // 设置ToolBar数据
    self.statusToolBar.status = self.statusFrame.status;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
