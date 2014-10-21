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
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *reweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end
@implementation WBStatusToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
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

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

/**
 *  初始化分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  创建按钮
 *
 *  @param title   按钮标题
 *  @param image   按钮图片
 *  @param bgImage 按钮背景图片
 *
 *  @return 按钮
 */
- (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString  *)bgImage
{
    // 创建按钮
    UIButton *button = [[UIButton alloc]init];
    
    // 设置按钮
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setBackgroundImage:[UIImage imageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    // 添加到按钮数组
    [self.btns addObject:button];
    return button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    // 设置按钮frame
    int dividerCount = self.dividers.count;
    CGFloat dividerW = 2;
    CGFloat btnW = (self.frame.size.width - dividerCount * dividerW) / self.btns.count;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i = 0; i < self.btns.count; ++i) {
        UIButton *btn = self.btns[i];

        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 设置分割线frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0; j < self.dividers.count; ++j) {
        UIImageView *divider = self.dividers[j];
        
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
        
    }
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
