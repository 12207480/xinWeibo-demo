//
//  mySettingCell.h
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingItem;

@interface SettingCell : UITableViewCell
@property (nonatomic, strong) SettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
