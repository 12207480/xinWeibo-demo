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

@interface WBDetailViewController ()<WBDetailHeaderDelegate>
@property (nonatomic, weak) WBDetailToolBar *toolBar;
@property (nonatomic, strong) WBDetailCellframe *detailFrame;
@property (nonatomic, strong) WBDetailHeader *header;
@end

@implementation WBDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"微博正文";
    
    

    self.detailFrame = [[WBDetailCellframe alloc]init];
    self.detailFrame.status = self.status;
    // 添加toolbar
    [self setupToolBar];
    
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
    return section == 0 ? 1 : 10;
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
    }
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }

    return cell;

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
    }
    return 40;
}

// tableview Headerview
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    if (self.header == nil) {
        self.header = [[WBDetailHeader alloc]init];
        self.header.status = self.status;
        self.header.delegate = self;
    }
    return self.header;
}

// tableview Headerview高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section ? 44 : 0;
}

// 实现代理
- (void)detailHeader:(WBDetailHeader *)header clickedBtnType:(DetailHeaderBtnType)index
{
    if (index == kDetailHeaderBtnTypeComment) { // 点击了评论
        [WBStatusTool commentsDataWithSinceId:0 maxId:0 statusId:[self.status.idstr longLongValue]success:^(NSArray *comments) {
            NSLog(@"%@",comments);
        } failure:^(NSError *error) {
            
        }];
        
    } else if (index == kDetailHeaderBtnTypeRepost) { // 点击了转发
        [WBStatusTool reportsDataWithSinceId:0 maxId:0 statusId:[self.status.idstr longLongValue] success:^(NSArray *reports) {
            NSLog(@"%@",reports);
        } failure:^(NSError *error) {

        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置toolbar不随tableview移动
    CGFloat toolbarY = self.view.frame.size.height - DetailToolBarHeight;
    
    self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, toolbarY +self.tableView.contentOffset.y , self.toolBar.frame.size.width, self.toolBar.frame.size.height);
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
