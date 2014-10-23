//
//  WBDetailViewController.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDetailViewController.h"
#import "WBDetailToolBar.h"
#import "WBDetailCell.h"
#import "WBDetailCellframe.h"
#import "WBStatus.h"
#import "WBDetailHeader.h"
#import "WBComment.h"
#import "WBStatusTool.h"
#import "WBBaseTextframe.h"
#import "WBCommentCell.h"
#import "WBRepostCell.h"
#import "MJRefresh.h"

@interface WBDetailViewController ()<WBDetailHeaderDelegate>
@property (nonatomic, weak) WBDetailToolBar *toolBar;
@property (nonatomic, strong) WBDetailCellframe *detailFrame;
@property (nonatomic, strong) WBDetailHeader *header;

@property (nonatomic, strong) NSMutableArray *commentFrames;
@property (nonatomic, strong) NSMutableArray *repostFrames;
@end

@implementation WBDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"微博正文";
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    self.detailFrame = [[WBDetailCellframe alloc]init];
    self.detailFrame.status = self.status;
    
    // 添加toolbar
    [self setupToolBar];
    
    // 上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
}

- (NSMutableArray *)commentFrames
{
    if (_commentFrames == nil) {
        _commentFrames = [NSMutableArray array];
    }
    return _commentFrames;
}

- (NSMutableArray *)repostFrames
{
    if (_repostFrames == nil) {
        _repostFrames = [NSMutableArray array];
    }
    return _repostFrames;
}

// 设置tableview工具条
- (void)setupToolBar
{
    WBDetailToolBar *toolBar = [[WBDetailToolBar alloc]init];
    
    CGFloat toolBarH = DetailToolBarHeight;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarY = self.view.frame.size.height - toolBarH;
    toolBar.frame = CGRectMake(0, toolBarY, toolBarW, toolBarH);
    
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// tableview有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

// tableview每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else if(self.header.currentBtnType == kDetailHeaderBtnTypeComment) {
        return self.commentFrames.count;
    } else {
        return self.repostFrames.count;
    }
}

// tableview cell创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellID = @"DetailCell";
        WBDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            cell = [[WBDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        
        //cell.backgroundColor = [UIColor blueColor];
        cell.statusFrame = self.detailFrame;
        return cell;
    } else if(self.header.currentBtnType == kDetailHeaderBtnTypeComment) {
        // 评论
        static NSString *CellID = @"commentCell";
        WBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            cell = [[WBCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        cell.cellFrame = self.commentFrames[indexPath.row];
        return cell;
    } else {
        // 转发
        static NSString *CellID = @"repostCell";
        WBRepostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            cell = [[WBRepostCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        cell.cellFrame = self.repostFrames[indexPath.row];
        return cell;

    }

}

// 取消点击高亮
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section;
}

// tableview cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.detailFrame.cellHeight;
    } else if (self.header.currentBtnType == kDetailHeaderBtnTypeComment) {
        return [self.commentFrames[indexPath.row] cellHeight];
    } else {
        return [self.repostFrames[indexPath.row] cellHeight];
    }
    return 40;
}

// tableview Headerview
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    return self.header;
}

- (WBDetailHeader *)header
{
    if (_header == nil) {
        _header = [[WBDetailHeader alloc]init];
        _header.status = self.status;
        _header.delegate = self;
    }
    return _header;
}

// tableview Headerview高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section ? 44 : 0;
}

// 实现代理
- (void)detailHeader:(WBDetailHeader *)header clickedBtnType:(DetailHeaderBtnType)index
{
    // 1.先刷新表格(马上显示对应的旧数据)
    [self.tableView reloadData];
    if (index == kDetailHeaderBtnTypeComment) { // 点击了评论
        [self loadNewComment];
        
    } else if (index == kDetailHeaderBtnTypeRepost) { // 点击了转发
        [self loadNewRepost];
    }
}

- (void)loadNewRepost
{
    long long firstId = 0;
    if (self.repostFrames.count) {
        WBBaseStatusframe *frame = self.repostFrames[0];
        firstId = [frame.status.idstr longLongValue];
    }
    [WBStatusTool repostsDataWithSinceId:firstId maxId:0 statusId:[self.status.idstr longLongValue] success:^(NSArray *reports) {
        //NSLog(@"%@",reports);
        NSMutableArray *newFrames = [NSMutableArray array];
        for (WBStatus *report in reports) {
            WBBaseTextframe *frame = [[WBBaseTextframe alloc]init];
            frame.status = report;
            [newFrames addObject:frame];
        }
        
        // 添加数据
        [self.repostFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        // 重新加载tableview
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (void)loadNewComment
{
    long long firstId = 0;
    if (self.commentFrames.count) {
        WBBaseStatusframe *frame = self.commentFrames[0];
        firstId = [frame.status.idstr longLongValue];
    }
    [WBStatusTool commentsDataWithSinceId:firstId maxId:0 statusId:[self.status.idstr longLongValue]success:^(NSArray *comments) {
        //NSLog(@"%@",comments);
        NSMutableArray *newFrames = [NSMutableArray array];
        for (WBComment *comment in comments) {
            WBBaseTextframe *frame = [[WBBaseTextframe alloc]init];
            frame.status = comment;
            [newFrames addObject:frame];
        }
        
        // 添加数据
        [self.commentFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        // 重新加载tableview
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (void)loadMoreData
{
    if (self.header.currentBtnType == kDetailHeaderBtnTypeComment) {
        [self loadMoreComment];
        // 让刷新控件停止显示刷新状态
        [self.tableView footerEndRefreshing];
    } else {
        [self loadMoreRepost];
        // 让刷新控件停止显示刷新状态
        [self.tableView footerEndRefreshing];
    }
}

- (void)loadMoreRepost
{
    long long lastId = 0;
    if (self.repostFrames.count) {
        WBBaseStatusframe *frame = self.repostFrames.lastObject;
        lastId = [frame.status.idstr longLongValue]-1;
    }
    
    [WBStatusTool repostsDataWithSinceId:0 maxId:lastId statusId:[self.status.idstr longLongValue] success:^(NSArray *reports) {
        //NSLog(@"%@",reports);
        NSMutableArray *newFrames = [NSMutableArray array];
        for (WBStatus *report in reports) {
            WBBaseTextframe *frame = [[WBBaseTextframe alloc]init];
            frame.status = report;
            [newFrames addObject:frame];
        }
        
        // 添加数据
        [self.repostFrames addObjectsFromArray:newFrames];
        
        // 重新加载tableview
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (void)loadMoreComment
{
    long long lastId = 0;
    if (self.commentFrames.count) {
        WBBaseStatusframe *frame = self.commentFrames.lastObject;
        lastId = [frame.status.idstr longLongValue] -1;
    }
    
    [WBStatusTool commentsDataWithSinceId:0 maxId:lastId statusId:[self.status.idstr longLongValue]success:^(NSArray *comments) {
        //NSLog(@"%@",comments);
        NSMutableArray *newFrames = [NSMutableArray array];
        for (WBComment *comment in comments) {
            WBBaseTextframe *frame = [[WBBaseTextframe alloc]init];
            frame.status = comment;
            [newFrames addObject:frame];
        }
        
        // 添加数据
        [self.commentFrames addObjectsFromArray:newFrames];
        
        // 重新加载tableview
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (void)loadNewStatus
{
    [WBStatusTool statusDataWithId:[self.status.idstr longLongValue] success:^(WBStatus *status) {
        self.status = status;
        self.detailFrame.status = status;
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置toolbar不随tableview移动
    CGFloat toolbarY = self.view.frame.size.height - DetailToolBarHeight;
    
    self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, toolbarY +self.tableView.contentOffset.y , self.toolBar.frame.size.width, self.toolBar.frame.size.height);
    [self.view bringSubviewToFront:self.toolBar];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
