//
//  WBComposePhotosView.h
//  XinWeibo
//
//  Created by tanyang on 14/10/18.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBComposePhotosView : UIView
/**
 *  添加图片
 */
- (void)addImage:(UIImage *)image;
/**
 *  返回所有image
 */
- (NSArray *)allImages;
@end
