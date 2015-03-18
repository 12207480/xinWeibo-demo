//
//  WBHotTopCell.m
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBHotTopCell.h"
#import "WBButton.h"

@interface WBHotTopCell()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;
@end
@implementation WBHotTopCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 36;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    
    self.btns = [NSMutableArray array];
    self.dividers = [NSMutableArray array];
    
    int count = 2;
    for (int i = 0; i < count; ++i) {
        WBButton *btn = [[WBButton alloc]init];
        [btn setTintColor:[UIColor blackColor]];
        [self addSubview:btn];
        [self.btns addObject:btn];
        if (i != count-1) {
            UIImageView *divider = [[UIImageView alloc] init];
            divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
            [self addSubview:divider];
            [self.dividers addObject:divider];
        }
    }
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    for (int i = 0; i < self.item.btnTiltles.count; ++i) {
        WBButton *btn = self.btns[i];
        NSString *title = self.item.btnTiltles[i];
        NSString *image = self.item.btnImages[i];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        if (image.length != 0) {
            [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
        }
    }
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
