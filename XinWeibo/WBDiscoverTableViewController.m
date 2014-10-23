//
//  WBDiscoverTableViewController.m
//  XinWeibo
//
//  Created by tanyang on 14-10-4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDiscoverTableViewController.h"
#import "WBSearchBar.h"

@interface WBDiscoverTableViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) WBSearchBar *searchBar;
@end

@implementation WBDiscoverTableViewController

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
    // 添加SearchBar
    [self setupSearchBar];
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
    //[super scrollViewDidScroll:scrollView];
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
