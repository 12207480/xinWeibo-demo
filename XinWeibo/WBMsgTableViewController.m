//
//  WBMsgTableViewController.m
//  XinWeibo
//
//  Created by tanyang on 14-10-4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBMsgTableViewController.h"
#import "MJRefresh.h"

@interface WBMsgTableViewController ()<RETableViewManagerDelegate>
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETableViewSection *section;
@end

@implementation WBMsgTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView delegate:self];
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    self.section = section;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.tableView addHeaderWithTarget:self action:(@selector(setupMsgData))];
    
    [self.tableView headerBeginRefreshing];
    // 设置消息数据
    //[self setupMsgdata];

    
}

- (void)setupMsgData
{
    RETableViewItem *myMsg = [RETableViewItem itemWithTitle:@"@我的" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        NSLog(@"点击了 @我的");
    }];
    myMsg.image = [UIImage imageWithName:@"new_friend"];
    
    RETableViewItem *report = [RETableViewItem itemWithTitle:@"评论" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        NSLog(@"点击了 评论");
    }];
    report.image = [UIImage imageWithName:@"draft"];
    
    RETableViewItem *good = [RETableViewItem itemWithTitle:@"赞" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        NSLog(@"点击了 赞");
    }];
    good.image = [UIImage imageWithName:@"like"];
    
    [self.section replaceItemsWithItemsFromArray:@[myMsg,report,good]];
    
    [self.tableView reloadData];
    
    [self.tableView headerEndRefreshing];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
