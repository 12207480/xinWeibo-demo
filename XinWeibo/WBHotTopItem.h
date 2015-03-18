//
//  WBHotTopItem.h
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "RETableViewItem.h"

@interface WBHotTopItem : RETableViewItem
@property (nonatomic, strong) NSMutableArray *btnTiltles;

@property (nonatomic, strong) NSMutableArray *btnImages;

- (void)setBtnsTitle:(NSString *)title btnsImage:(NSString *)image;

- (void)setBtnsTitle:(NSString *)title;

@end
