//
//  WBTabBarViewController.m
//  XinWeibo
//
//  Created by tanyang on 14-10-4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBTabBarViewController.h"
#import "WBHomeTableViewController.h"
#import "WBMsgTableViewController.h"
#import "WBDiscoverTableViewController.h"
#import "WBMeTableViewController.h"
#import "UIImage+WB.h"
#import "WBTabBar.h"
#import "WBNavigationController.h"
#import "WBComposeViewController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBHttpTool.h"

@interface WBTabBarViewController ()<WBTabbarDekegate>
@property (nonatomic, weak) WBTabBar *customTabBar;
@property (nonatomic, weak) WBHomeTableViewController *home;
@property (nonatomic, weak) WBMsgTableViewController *msg;
@property (nonatomic, weak) WBMeTableViewController *me;
@end

@implementation WBTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabBar];
    
    // 初始化所以子控制器
    [self setupAllChildViewControls];
    
    // 定时检查未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)checkUnreadCount
{
    // 封装参数请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"uid"] = @([WBAccountTool account].uid);
    
    // 发送请求
    [WBHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        //WBLog(@"加载home_timeline成功：%@",json);
        int unreadStatusCount = [json[@"status"] intValue];
        int unreadMsgCount = [json[@"notice"] intValue];
        int unreadFansCount = [json[@"follower"] intValue];
        
        self.home.tabBarItem.badgeValue = unreadStatusCount == 0 ? nil : [NSString stringWithFormat:@"%d",unreadStatusCount];
        self.msg.tabBarItem.badgeValue = unreadMsgCount == 0 ? nil : [NSString stringWithFormat:@"%d",unreadMsgCount];
        self.me.tabBarItem.badgeValue = unreadFansCount == 0 ? nil : [NSString stringWithFormat:@"%d",unreadFansCount];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


- (void)setupTabBar
{
    WBTabBar *customTabBar = [[WBTabBar alloc]init];
    customTabBar.delegate = self;
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

// tabbar代理方法 点击了哪个
- (void)tabBar:(WBTabBar *)tabBar didSelectedButtonfrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    if (to == 0) { // 点击首页
        [self.home refreshData];
    }
}

// tabbar代理方法 点击了加号按钮
- (void)tabBarDidClickedPlusButton:(WBTabBar *)tabBar
{
    WBComposeViewController *compose = [[WBComposeViewController alloc]init];
    WBNavigationController *nav = [[WBNavigationController alloc]initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)setupAllChildViewControls
{
    // 首页控制器
    WBHomeTableViewController *home = [[WBHomeTableViewController alloc]init];
    //home.tabBarItem.badgeValue = @"20";
    [self addChildViewControl:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    // 消息控制器
    WBMsgTableViewController *msg = [[WBMsgTableViewController alloc]init];
    //msg.tabBarItem.badgeValue = @"30";
    [self addChildViewControl:msg title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.msg = msg;
    
    // 广场控制器
    WBDiscoverTableViewController *discover = [[WBDiscoverTableViewController alloc]init];
    //discover.tabBarItem.badgeValue = @"60";
    [self addChildViewControl:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 我控制器
    WBMeTableViewController *me = [[WBMeTableViewController alloc]init];
    //me.tabBarItem.badgeValue = @"80";
    [self addChildViewControl:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.me = me;


}

- (void)addChildViewControl:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.view.backgroundColor = [UIColor whiteColor];
    childVc.title = title;
    // childVc.title 效果一样
    //childVc.tabBarItem.title = @"首页";
    //childVc.navigationItem.title = @"首页";
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    if (ios7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else {
        childVc.tabBarItem.selectedImage = [UIImage imageWithName:selectedImageName];
    }
    
    WBNavigationController *childVcNav = [[WBNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:childVcNav];
    // 添加自定义item
    [self.customTabBar addButtonWithItem:childVc.tabBarItem];
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
