//
//  WBComposeViewController.m
//  XinWeibo
//
//  Created by tanyang on 14/10/17.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBTextView.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "WBComposeToolBar.h"
#import "WBComposePhotosView.h"
#import "WBHttpTool.h"

@interface WBComposeViewController ()<UITextViewDelegate, WBComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) WBTextView *textView;
@property (nonatomic, weak) WBComposeToolBar *toolbar;
@property (nonatomic, weak) WBComposePhotosView *photosView;
@end

@implementation WBComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏属性
    [self setupNvaBar];
    
    // 添加textview
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolBar];
    
    // 添加imageview
    [self setupPhotosView];
}

- (void)setupPhotosView
{
    WBComposePhotosView *photosView = [[WBComposePhotosView alloc]init];
    CGFloat photosW = self.textView.frame.size.width;
    CGFloat photosY = 80;
    CGFloat photosH = self.textView.frame.size.height - photosY;
    photosView.frame = CGRectMake(0, photosY, photosW, photosH);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  添加toolbar
 */
- (void)setupToolBar
{
    WBComposeToolBar *toolbar = [[WBComposeToolBar alloc]init];
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)composeToolBar:(WBComposeToolBar *)toolbar didClickedButton:(WBComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case WBComposeToolbarButtonTypeCamera: // 相机
            //NSLog(@"相机");
            [self openCamera];
            break;
        case WBComposeToolbarButtonTypePicture: // 相册
            //NSLog(@"相册");
            [self openPicture];
            break;
        default:
            break;
    }
}

// 打开相机
- (void)openCamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 打开照片
- (void)openPicture
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 图片选择器代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 销毁pickview
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 取得图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addImage:image];
    
}

/**
 *  设置导航栏属性
 */
- (void)setupNvaBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

/**
 *  添加textview
 */
- (void)setupTextView
{
    // 添加控件
    WBTextView *textView = [[WBTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 监听textview文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将出现
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 取出键盘frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 取出键盘弹出时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
    }];
}

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)notification
{
    // 取出键盘弹出时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  监听textview文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length !=0);
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  退出发微博
 */
- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送微博
 */
- (void)sendStatus
{
    if (self.photosView.allImages.count) {
        [self sendStatusTextAndImage];
    } else {
        [self sendStatusText];
    }

}

- (void)sendStatusText
{
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 发送请求
    [WBHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功！"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败！"];
    }];
    
    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendStatusTextAndImage
{
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 封装文件参数
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *images = [self.photosView allImages];
    for (UIImage *image in images) {
        WBFormData *formData = [[WBFormData alloc]init];
        formData.data = UIImageJPEGRepresentation(image, 0.8);
        formData.name = @"pic";
        formData.mimeType = @"image/jpeg";
        formData.filename = @"";
        [formDataArray addObject:formData];
    }
    
    // 发送请求
    [WBHttpTool postWithURL:@"https://api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功！"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败！"];
    }];
    
    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];

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
