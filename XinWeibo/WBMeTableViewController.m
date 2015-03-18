//
//  WBMeTableViewController.m
//  XinWeibo
//
//  Created by tanyang on 14-10-4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBMeTableViewController.h"
#import "SettingItem.h"
#import "SettingGroup.h"
#import "SettingSwitchItem.h"
#import "SettingArrowItem.h"
#import "WBTestViewController.h"

@interface WBMeTableViewController ()

@end

@implementation WBMeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.groupSpace = 16;
    NSLog(@"backgroundColor:%@",self.tableView.backgroundColor);
    // 第一组
    SettingItem *myFriend = [SettingArrowItem itemWithIcon:@"new_friend" title:@"我的好友" destVcClass:[WBTestViewController class]];
    
    SettingGroup *group0 = [[SettingGroup alloc]init];
    //group0.header = @"推送和提醒";
    //group0.footer = @"推送和提醒";
    group0.items = @[myFriend];
    
    [self.data addObject:group0];
    
    // 第二组
    SettingItem *myPhoto = [SettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:[WBTestViewController class]];
    SettingItem *myRecieve = [SettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:[WBTestViewController class]];
    SettingItem *praise = [SettingSwitchItem itemWithIcon:@"like" title:@"赞"];
    SettingGroup *group1 = [[SettingGroup alloc]init];
    group1.items = @[myPhoto,myRecieve,praise];
    
    [self.data addObject:group1];
    
    
    // 第三组
    SettingItem *weiboPay = [SettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:[WBTestViewController class]];
    SettingItem *personalized = [SettingArrowItem itemWithIcon:@"vip" title:@"个性化" destVcClass:[WBTestViewController class]];
    SettingGroup *group2 = [[SettingGroup alloc]init];
    group2.items = @[weiboPay,personalized];
    
    [self.data addObject:group2];
    
    // 第四组
    SettingItem *mycard = [SettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:[WBTestViewController class]];
    SettingItem *email = [SettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:[WBTestViewController class]];
    SettingGroup *group3 = [[SettingGroup alloc]init];
    group3.items = @[mycard,email];
    
    [self.data addObject:group3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
