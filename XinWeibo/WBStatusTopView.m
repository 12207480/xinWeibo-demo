//
//  WBStatusTopView.m
//  XinWeibo
//
//  Created by tanyang on 14-10-14.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBStatusTopView.h"
#import "WBBaseStatusframe.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "WBRetweetStatusView.h"
#import "WBPhotosView.h"
#import "WBPhoto.h"

@interface WBStatusTopView()
// 头像
@property (nonatomic, weak) UIImageView *iconView;
// 会员图标
@property (nonatomic, weak) UIImageView *vipView;
// 配图
@property (nonatomic, weak) WBPhotosView *photoView;
// 昵称
@property (nonatomic, weak) UILabel *nameLabel;
// 时间
@property (nonatomic, weak) UILabel *timeLabel;
// 来源
@property (nonatomic, weak) UILabel *sourceLabel;
// 正文
@property (nonatomic, weak) UILabel *contentLabel;


@end
@implementation WBStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        // 添加图标view
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 添加vipview
        UIImageView *vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 添加配图view
        WBPhotosView *photoView = [[WBPhotosView alloc]init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
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
        
        // 来源
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = WBStatusSourceFont;
        sourceLabel.textColor = WBColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 正文
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.font = WBStatusContentFont;
        contentLabel.textColor = WBColor(39, 39, 39);
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        // 被转发微博的view
        WBRetweetStatusView *retweetView = [[WBRetweetStatusView alloc]init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}


- (void)setStatusFrame:(WBBaseStatusframe *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.取出模型数据
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewFrame;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelFrame;
    
    // 4.vip
    if (user.mbtype > 2) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewFrame;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.nameLabelFrame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelFrame) + WBStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:WBStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + WBStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:WBStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelFrame;
    
    // 8.配图
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewFrame;
        self.photoView.photos = status.pic_urls;
    } else {
        self.photoView.hidden = YES;
    }
    
    // 9.被转发微博
    WBStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewFrame;
        
        // 传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    } else {
        self.retweetView.hidden = YES;
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
