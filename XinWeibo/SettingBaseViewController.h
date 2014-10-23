//
//  SettingBaseViewController.h
//  Lottery Ticket
//
//  Created by tanyang on 14-9-26.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingBaseViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *data;
/**
 *  分组之间的间距
 */
@property (nonatomic, assign) CGFloat groupSpace;
@end
