//
//  WBPhotosView.m
//  XinWeibo
//
//  Created by tanyang on 14-10-15.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBPhotosView.h"
#import "WBPhoto.h"
#import "WBPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define WBPhotoW 70
#define WBPhotoH 70
#define WBPhotoMargin 10
@implementation WBPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加9个imageview
        for (int i = 0; i < 9; ++i) {
            WBPhotoView *photoView = [[WBPhotoView alloc]init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    //NSLog(@"点击了图片--%d",recognizer.view.tag);
    int count = self.photos.count;
    
    // 封装图片
    NSMutableArray *myPhotos = [NSMutableArray array];
    for (int i = 0;  i < count; ++i) {
        MJPhoto *mjphoto = [[MJPhoto alloc]init];
        mjphoto.srcImageView = self.subviews[i];
        
        WBPhoto *wbphoto = self.photos[i];
        NSString *photoUrl = [wbphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl];
        [myPhotos addObject:mjphoto];
    }
    
    // 显示图片浏览器
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc]init];
    photoBrowser.currentPhotoIndex = recognizer.view.tag;
    photoBrowser.photos = myPhotos;
    [photoBrowser show];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i < self.subviews.count; ++i) {
        // 取出各个imageview
        WBPhotoView *photoView = self.subviews[i];
        
        if (i < photos.count) {
            // 显示图片传递数据
            photoView.hidden = NO;
            photoView.photo = photos[i];
            
            // 设置图片frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (WBPhotoW + WBPhotoMargin);
            CGFloat photoY = row * (WBPhotoH + WBPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, WBPhotoW, WBPhotoH);
            
            // 设置图片缩放
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else {
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)photosViewSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * WBPhotoH + (rows - 1) * WBPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * WBPhotoW + (cols - 1) * WBPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
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
