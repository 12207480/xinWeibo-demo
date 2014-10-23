//
//  WBBaseTextCell.m
//  XinWeibo
//
//  Created by tanyang on 14/10/22.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBBaseTextCell.h"
#import "WBBaseTextframe.h"
#import "WBBaseStatus.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"

@interface WBBaseTextCell()
// 头像
@property (nonatomic, weak) UIImageView *iconView;
// 会员图标
@property (nonatomic, weak) UIImageView *vipView;
// 昵称
@property (nonatomic, weak) UILabel *nameLabel;
// 时间
@property (nonatomic, weak) UILabel *timeLabel;
// 正文
@property (nonatomic, weak) UILabel *contentLabel;
@end
@implementation WBBaseTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // 添加内部子控件
        [self setupSubViews];
        
    }
    return self;
}

- (void)setupSubViews
{
    // 添加图标view
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 添加vipview
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [self addSubview:vipView];
    self.vipView = vipView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = WBStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = WBStatusTimeFont;
    timeLabel.textColor = WBColor(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 正文
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = WBStatusContentFont;
    contentLabel.textColor = WBColor(39, 39, 39);
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)setCellFrame:(WBBaseTextframe *)cellFrame
{
    _cellFrame = cellFrame;
    
    WBBaseStatus *status = cellFrame.status;
    
    WBUser *user = status.user;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.cellFrame.iconViewFrame;
    
    // 昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.cellFrame.nameLabelFrame;
    
    // vip
    if (user.mbtype > 2) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.cellFrame.vipViewFrame;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }
    
    // 正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.cellFrame.contentLabelFrame;
    
    // 时间
    self.timeLabel.frame = cellFrame.timeLabelFrame;
    self.timeLabel.text = status.created_at;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
