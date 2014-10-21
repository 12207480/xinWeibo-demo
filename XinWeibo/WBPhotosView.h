//
//  WBPhotosView.h
//  XinWeibo
//
//  Created by tanyang on 14-10-15.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPhotosView : UIView
// 图片数组
@property (nonatomic, strong) NSArray *photos;

/**
 *  返回uiview大小根据图片个数
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
