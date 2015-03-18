//
//  MyButton.m
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBButton.h"

@interface WBButton()
@property (nonatomic, strong) UIFont *titleFont;

@end

@implementation WBButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

// 从文件中解析一个对象的时候调用这个方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
- (void)setUp
{
    self.titleFont = [UIFont systemFontOfSize:14];
    self.titleLabel.font = self.titleFont;
    
    // 图标居中
    self.imageView.contentMode = UIViewContentModeCenter;
}


// 改写控制器内部label 的frame   contentRect : 按钮的边框
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 10;
    CGFloat titleY = 0;
    CGFloat titleW;
    NSDictionary *attrs = @{NSFontAttributeName: self.titleFont};
    if (ios7) {
#ifdef __IPHONE_7_0
        titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
#endif
    }else {
        titleW = [self.currentTitle sizeWithFont:self.titleFont].width;
    }
    CGFloat titleH = contentRect.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

// 改写控制器内部 imageView 的 frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 48;
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame)-2;;
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
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
