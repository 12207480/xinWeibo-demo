//
//  WBDetailViewController.h
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatus;
@interface WBDetailViewController : UITableViewController
@property (nonatomic, strong) WBStatus *status;
@end
