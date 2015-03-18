//
//  WBDiscoverTableViewController.m
//  XinWeibo
//
//  Created by tanyang on 14-10-4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDiscoverTableViewController.h"
#import "RETableViewManager.h"
#import "WBSearchBar.h"
#import "WBADImageItem.h"
#import "WBHotTopItem.h"
#import "WBSubtitleItem.h"

@interface WBDiscoverTableViewController ()<UITextFieldDelegate, RETableViewManagerDelegate>

@property (nonatomic, weak) WBSearchBar *searchBar;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, assign) CGFloat groupSpace;
@end

#define SectionHeaderHeight 12
#define SectionFooterHeight 0.5
@implementation WBDiscoverTableViewController

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建RETableViewManager管理类
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView delegate:self];
    
    // 设置tableview边框
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 6, 0);
    
    // 设置分割线
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    // 添加SearchBar
    [self setupSearchBar];
    
    //添加广告视图
    [self setupAdvertView];
    
    // 添加热门话题
    [self setupHotTopic];
    
    // 添加其他信息
    [self setupOtherInfo];
    
}

- (void)setupOtherInfo
{
    // 注册cell
    self.manager[@"WBSubtitleItem"] = @"WBSubtitleCell";
    
    // 设置第三组
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    
    // 设置item
    WBSubtitleItem *hotWeibo = [WBSubtitleItem itemWithTitle:@"热门微博" subtitle:@"笑话，娱乐，神最右都搬到这里来啦" imageName:@"hot_status"];
    WBSubtitleItem *findpeople = [WBSubtitleItem itemWithTitle:@"找人" subtitle:@"名人，专家，有趣的人尽在这里" imageName:@"find_people"];
    [section addItemsFromArray:@[hotWeibo,findpeople]];
    
    // 设置第四组
    section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    
    // 设置item
    WBSubtitleItem *gameCenter = [WBSubtitleItem itemWithTitle:@"游戏中心" imageName:@"game_center"];
    // 发现身边的有缘人，有趣事
    WBSubtitleItem *near = [WBSubtitleItem itemWithTitle:@"周边" subtitle:@"发现身边" imageName:@"near"];
    //near.accessoryType
    near.subtitleAlignment = NSTextAlignmentRight;
    near.subtitleFont = [UIFont systemFontOfSize:14];
    [section addItemsFromArray:@[gameCenter,near]];
    
    // 设置第五组
    section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    
    // 设置item
    WBSubtitleItem *movice = [WBSubtitleItem itemWithTitle:@"电影" imageName:@"movie"];
    WBSubtitleItem *Song = [WBSubtitleItem itemWithTitle:@"听歌" imageName:@"music"];
    WBSubtitleItem *interest = [WBSubtitleItem itemWithTitle:@"发现兴趣" imageName:@"more"];
    [section addItemsFromArray:@[movice,Song,interest]];
}

- (void)setupHotTopic
{
    // 注册cell
    self.manager[@"WBHotTopItem"] = @"WBHotTopCell";
    
    // 设置第二组
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    
    // 设置cell item
    WBHotTopItem *item0 = [[WBHotTopItem alloc]init];
    [item0 setBtnsTitle:@"秒杀iPhone6" btnsImage:@"expand"];
    [item0 setBtnsTitle:@"双10抢购"];
    
    WBHotTopItem *item1 = [[WBHotTopItem alloc]init];
    [item1 setBtnsTitle:@"OMG猫"];
    [item1 setBtnsTitle:@"热门话题" btnsImage:@"expand"];
    
    // 添加item
    [section addItem:item0];
    [section addItem:item1];
}

- (void)setupAdvertView
{
    // 注册cell
    self.manager[@"WBADImageItem"] = @"WBADImageCell";
    
    // 设置第一组
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight/2;
    section.footerHeight = SectionFooterHeight;
    
    // 设置cell item
    WBADImageItem *item = [WBADImageItem itemWithImageNamed:@"square_ad"];
    
    // 如果self 引用了 item 则需要下面解决循环引用
    //__typeof (&*self) __weak weakSelf = self;;
    item.selectionHandler = ^(WBADImageItem *item){
        NSLog(@"点击了图片");
    };
    // 添加item
    [section addItem:item];
}

- (void)setupSearchBar
{
    WBSearchBar *searchBar = [WBSearchBar searchBar];
    searchBar.delegate = self;
    // 设置大小
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
