//
//  WBStatusToolBar.m
//  XinWeibo
//
//  Created by tanyang on 14-10-14.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "WBStatus.h"

@interface WBStatusToolBar ()

@property (nonatomic, weak) UIButton *reweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end
@implementation WBStatusToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 添加按钮
        self.reweetBtn = [self buttonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self buttonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self buttonWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        // 添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (void)setStatus:(WBStatus *)status
{
    _status = status;

    // 转发数
    [self setupButton:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    [self setupButton:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    [self setupButton:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
}

- (void)setupButton:(UIButton *)button originalTitle:(NSString *)originalTitle count:(int)count
{
    if (count) {
        NSString *title = nil;
        if (count < 10000) { // 小于1W
            title = [NSString stringWithFormat:@"%d",count];
        } else {
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",countDouble];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
        [button setTitle:title forState:UIControlStateNormal];
    } else {
        [button setTitle:originalTitle forState:UIControlStateNormal];
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
