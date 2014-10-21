//
//  WBTextView.m
//  XinWeibo
//
//  Created by tanyang on 14/10/17.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView()
@property (nonatomic ,weak) UILabel *placeholderLable;
@end
@implementation WBTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *placeholderLable = [[UILabel alloc]init];
        placeholderLable.textColor = [UIColor lightGrayColor];
        placeholderLable.hidden = YES;
        placeholderLable.numberOfLines = 0;
        placeholderLable.font = self.font;
        //[self addSubview:placeholderLable];
        [self insertSubview:placeholderLable atIndex:0];
        self.placeholderLable = placeholderLable;
        
        // 监听textview文字改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLable.text = placeholder;
    if (placeholder.length) { // 需要显示
        self.placeholderLable.hidden = NO;
        
        // 计算frame
        CGFloat lableX = 5;
        CGFloat lableY = 7;
        CGFloat lableMaxW = self.frame.size.width - 2 * lableX;
        CGFloat lableMaxH = self.frame.size.height - 2 * lableY;

        CGSize lableSize = [placeholder sizeWithFont:self.placeholderLable.font constrainedToSize:CGSizeMake(lableMaxW, lableMaxH)];
        self.placeholderLable.frame = CGRectMake(lableX, lableY, lableSize.width, lableSize.height);
    } else {
        self.placeholderLable.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLable.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLable.font = font;
    // 重新计算字体frame
    self.placeholder = self.placeholder;
}

- (void)textDidChange
{
    self.placeholderLable.hidden = (self.text.length != 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
