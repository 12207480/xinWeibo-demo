//
//  WBStatuseCell.h
//  XinWeibo
//
//  Created by tanyang on 14-10-13.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusframe;
@interface WBStatusCell : UITableViewCell
@property (nonatomic, strong) WBStatusframe *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
