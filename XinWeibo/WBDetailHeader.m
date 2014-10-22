//
//  WBDetailHeader.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDetailHeader.h"
#import "WBStatus.h"

@interface WBDetailHeader()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *reweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@property (nonatomic, weak) UIImageView *selectedImageView;
@property (nonatomic, weak) UIButton *selectedBtn;
@end


@implementation WBDetailHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        // 设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        
        // 添加按钮
        self.commentBtn = [self buttionWithTitle:@"评论"];
        self.reweetBtn = [self buttionWithTitle:@"转发"];
        self.attitudeBtn = [self buttionWithTitle:@"赞"];
        [self setupDivider];
        
        // 添加下标按钮
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"statusdetail_segmented_bottom_arrow"]];
        [self addSubview:imageView];
        self.selectedImageView = imageView;
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

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    [self setupButton:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    [self setupButton:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    [self setupButton:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
}

/**
 *  创建按钮
 */
- (UIButton *)buttionWithTitle:(NSString *)title
{
    // 创建按钮
    UIButton *button = [[UIButton alloc]init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    // 添加到按钮数组
    [self.btns addObject:button];
    return button;
}

- (void)setupButton:(UIButton *)button originalTitle:(NSString *)originalTitle count:(int)count
{
    if (count) {
        NSString *title = nil;
        if (count < 10000) { // 小于1W
            title = [NSString stringWithFormat:@"%d %@",count,originalTitle];
        } else {
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万 %@",countDouble,originalTitle];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
        [button setTitle:title forState:UIControlStateNormal];
    } else {
        [button setTitle:originalTitle forState:UIControlStateNormal];
    }
}

- (void)clickedButton:(UIButton *)button
{
    // 控制按钮
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    // 移动下标图片
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = self.selectedImageView.center;
        center.x = button.center.x;
        self.selectedImageView.center = center;
    }];
    
    // 通知代理
    if ([_delegate respondsToSelector:@selector(detailHeader:clickedBtnType:)]) {
        DetailHeaderBtnType type = (button == _commentBtn ? kDetailHeaderBtnTypeComment : kDetailHeaderBtnTypeRepost);
        [_delegate detailHeader:self clickedBtnType:type];
    }
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int dividerCount = self.dividers.count;
    CGFloat dividerW = 2;
    CGFloat btnW = (self.frame.size.width - 20 - dividerCount * dividerW) / self.btns.count;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i = 0; i < self.btns.count; ++i) {
        UIButton *btn = self.btns[i];
        
        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        if (i == self.btns.count-1) {
            btn.frame = CGRectMake(btnX, btnY, btnW + 20, btnH);
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            btn.enabled = NO;
        }
    }
    
    // 设置分割线frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0; j < dividerCount; ++j) {
        UIImageView *divider = self.dividers[j];
        
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
        
    }

    UIButton *btn = self.btns[0];
    CGFloat selectedImageY = btn.frame.size.height -_selectedImageView.frame.size.height-2;
    _selectedImageView.frame = CGRectMake(0, selectedImageY, _selectedImageView.frame.size.width, _selectedImageView.frame.size.height);
    [self clickedButton:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
