//
//  WBOAuthViewController.m
//  XinWeibo
//
//  Created by tanyang on 14-10-9.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "WBAccountTool.h"
#import "WBWeiboTool.h"
#import "MBProgressHUD+MJ.h"

@interface WBOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加webview
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 加载授权
    NSString *oAuthStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",WBAppKey,WBRedirectUrl];
    NSURL *url = [NSURL URLWithString:oAuthStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"加载中"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 请求的url路径
    NSString *urlStr = request.URL.absoluteString;
    //NSLog(@"%@",urlStr);
    
    // 查找code=的位置
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 如果找到,截取code
    if (range.length > 0) {
        NSString *code = [urlStr substringFromIndex:range.location+range.length];
        NSLog(@"%@",code);
        // 发生请求，用code 换取token
        [self accessTokenWithCode:code];
        return NO;
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    // 获取accessToken
    [WBAccountTool accessTokenWithCode:code success:^{
        // 选择控制器
        [WBWeiboTool chooseRootViewController];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        WBLog(@"accessToken请求失败：%@",error);
        
        [MBProgressHUD hideHUD];
    }];
    
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
