//
//  WBHomeTableViewController.m
//  XinWeibo
//
//  Created by tanyang on 14-10-4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBHomeTableViewController.h"
#import "UIBarButtonItem+WB.h"
#import "WBTitleButton.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "WBStatusframe.h"
#import "WBStatusCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "WBHttpTool.h"
#import "WBDetailViewController.h"
#import "WBStatusTool.h"
#import "WBUserTool.h"

#define WBTitleButtonImageUp -1
#define WBTitleButtonImageDown 0
@interface WBHomeTableViewController ()
@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, weak) WBTitleButton *titleButton;
@end

@implementation WBHomeTableViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // 设置刷新控件
    [self setupRefreshView];
    
    // 导航栏按钮
    [self setupNavItem];
    
    // 获得用户信息
    [self setupUserData];
}

- (void)setupUserData
{
    // 获取用户数据
    [WBUserTool userDataWithSuccess:^(WBUser *user) {
        // 设置标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
    } failure:^(NSError *error) {

    }];
    
}

// 设置刷新控件
- (void)setupRefreshView
{
    /****************系统自带刷新控件********************
     // 添加刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    // 自动进入刷新，不会调用刷新函数
    [refreshControl beginRefreshing];
    
    // 直接加载数据
    [self refreshControlStateChange:refreshControl];
     *************************************************/
    
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    
    // 自动刷新
    [self.tableView headerBeginRefreshing];
    
    // 上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
}

- (void)refreshData
{
    if (self.tabBarItem.badgeValue) {
        [self.tableView headerBeginRefreshing];
    }
}

- (void)loadNewData
{
    // 清除提醒数字
    self.tabBarItem.badgeValue = nil;
    
    long long sinceId = 0;
    // 判断是否第一次调用
    if (self.statusFrames.count) {
        WBStatusframe *statusFrame = self.statusFrames[0];
        sinceId = [statusFrame.status.idstr longLongValue];
    }
    
    // 发送请求
    [WBStatusTool statusDataWithSinceId:sinceId maxId:0 success:^(NSArray *statuses) {
        //statusFrames添加status数据
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            
            WBStatusframe *statusFrame = [[WBStatusframe alloc]init];
            statusFrame.status = status;
            [statusFrames addObject:statusFrame];
        }
        
            // 添加新旧数据
            NSMutableArray *tmpArray = [NSMutableArray array];
            [tmpArray addObjectsFromArray:statusFrames];
            [tmpArray addObjectsFromArray:self.statusFrames];
            
            self.statusFrames = tmpArray;
            
            // 刷新表格
            [self.tableView reloadData];
            
            // 让刷新控件停止显示刷新状态
            [self.tableView headerEndRefreshing];
            
            // 显示最新微博的数量
            [self showNewStatusCount:statusFrames.count];
    } failure:^(NSError *error) {
        WBLog(@"加载home_timeline失败：%@",error);
        // 让刷新控件停止显示刷新状态
        [self.tableView headerEndRefreshing];
    } ];
    
}

- (void)loadMoreData
{
    long long maxId = 0;
    // 判断是否第一次调用
    if (self.statusFrames.count) {
        WBStatusframe *statusFrame = self.statusFrames.lastObject;
        // 加载ID <= max_id的微博
        maxId = [statusFrame.status.idstr longLongValue] - 1;
    }
    
    // 发送请求
    [WBStatusTool statusDataWithSinceId:0 maxId:maxId success:^(NSArray *statuses) {
        //statusFrames添加status数据
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            WBStatusframe *statusFrame = [[WBStatusframe alloc]init];
            statusFrame.status = status;
            [statusFrames addObject:statusFrame];
        }
            
        // 添加旧数据
        [self.statusFrames addObjectsFromArray:statusFrames];
            
        // 刷新表格
        [self.tableView reloadData];
                    
        // 让刷新控件停止显示刷新状态
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        WBLog(@"加载home_timeline失败：%@",error);
        // 让刷新控件停止显示刷新状态
        [self.tableView footerEndRefreshing];
    }];

}


// 刷新控件响应,加载数据
//- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
//{
//    // 创建请求对象
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    // 封装参数请求
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [WBAccountTool account].access_token;
//    params[@"count"] = @10;
//    
//    // 判断是否第一次调用
//    if (self.statusFrames.count) {
//        WBStatusframe *statusFrame = self.statusFrames[0];
//        params[@"since_id"] = statusFrame.status.idstr;
//    }
//    
//    // 发送请求
//    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //NSLog(@"加载home_timeline成功：%@",responseObject);
//        // 将字典数组转为模型数组
//        NSMutableArray *statusFrames = [NSMutableArray array];
//        NSArray *statuses = [WBStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        for (WBStatus *status in statuses) {
//            WBStatusframe *statusFrame = [[WBStatusframe alloc]init];
//            statusFrame.status = status;
//            [statusFrames addObject:statusFrame];
//        }
//        
//        // 添加新旧数据
//        NSMutableArray *tmpArray = [NSMutableArray array];
//        [tmpArray addObjectsFromArray:statusFrames];
//        [tmpArray addObjectsFromArray:self.statusFrames];
//        
//        self.statusFrames = tmpArray;
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止显示刷新状态
//        [refreshControl endRefreshing];
//        
//        // 显示最新微博的数量
//        [self showNewStatusCount:statusFrames.count];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //NSLog(@"加载home_timeline失败：%@",error);
//        // 让刷新控件停止显示刷新状态
//        [refreshControl endRefreshing];
//    }];
//
//}

// 显示最新微博的数量
- (void)showNewStatusCount:(int)count
{
    // 添加按钮
    UIButton *button = [[UIButton alloc]init];
    
    //插入navbar之下
    [self.navigationController.view insertSubview:button belowSubview:self.navigationController.navigationBar];
    
    button.userInteractionEnabled = NO;
    // 设置图片文字
    [button setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博",count];
        [button setTitle:title forState:UIControlStateNormal];
    } else {
        [button setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 设置button frame
    CGFloat buttonH = 32;
    CGFloat buttonX = 0;
    CGFloat buttonY = 64 - buttonH;
    CGFloat buttonW = self.view.frame.size.width;
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    // 按钮移动动画
    [UIView animateWithDuration:0.8 animations:^{
        button.transform = CGAffineTransformMakeTranslation(0, buttonH + 1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [button removeFromSuperview];
        }];
    }];
    
   
    }

// 导航栏按钮
- (void)setupNavItem
{
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highlightIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highlightIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    WBTitleButton *titleButton = [[WBTitleButton alloc]init];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 30);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    // 清除边框线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WBColor(226, 226, 226);
    
    self.tableView.contentInset= UIEdgeInsetsMake(0, 0, WBStatusTableBorder, 0);
}

// 点击title图标
- (void)titleClick:(WBTitleButton *)titleButton
{
    // 设置图标上下动画
    if (titleButton.tag == WBTitleButtonImageUp) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = WBTitleButtonImageDown;
    }
    else {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = WBTitleButtonImageUp;
    }
    
}

// 点击查找好友
- (void)findFriend
{
    NSLog(@"findFriend");
}

// 点击
- (void)pop
{
    NSLog(@"pop");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    // 传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusframe *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBDetailViewController *detail = [[WBDetailViewController alloc]init];
    WBStatusframe *statusframe =self.statusFrames[indexPath.row];
    detail.status = statusframe.status;
    [self.navigationController pushViewController:detail animated:YES];
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
