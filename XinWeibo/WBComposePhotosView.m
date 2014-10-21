//
//  WBComposePhotosView.m
//  XinWeibo
//
//  Created by tanyang on 14/10/18.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (NSArray *)allImages
{
    NSMutableArray *images = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
    }
    return images;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.subviews.count;
    CGFloat imageViewH = 80;
    CGFloat imageViewW = 80;
    int maxColumns = 3;
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewH)/(maxColumns+1);
    for (int i = 0; i < count; ++i) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewW + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewH, imageViewW);
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
