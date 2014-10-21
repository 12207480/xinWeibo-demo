//
//  WBPhotoView.m
//  XinWeibo
//
//  Created by tanyang on 14-10-15.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBPhotoView.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"

@interface WBPhotoView()
@property (nonatomic,weak) UIImageView *gifView;
@end
@implementation WBPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加gif图标
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
        
    }
    return self;
}

- (void)setPhoto:(WBPhoto *)photo
{
    _photo = photo;
    
    // 设置gif是否可见
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@".gif"];
    
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置锚点
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
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
