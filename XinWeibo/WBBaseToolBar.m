//
//  WBBaseToolBar.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBBaseToolBar.h"

@interface WBBaseToolBar()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

@end
@implementation WBBaseToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
