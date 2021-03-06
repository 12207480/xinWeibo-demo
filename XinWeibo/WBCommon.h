

// 判断是否为ios7
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 获得RGB颜色
#define WBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 是否是4寸iPhone
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568)

/*授权 账号相关*/
#define WBAppKey        @"568898243"
#define WBAppSecret     @"38a4f8204cc784f81f9f0daaf31e02e3"
#define WBRedirectUrl   @"http://www.sharesdk.cn"

// 自定义Log
#ifdef DEBUG
#define WBLog(...) NSLog(__VA_ARGS__)
#else
#define WBLog(...)
#endif

/*微博Statuts cell的属性*/
// 昵称字体
#define WBStatusNameFont [UIFont systemFontOfSize:13]
// 时间字体
#define WBStatusTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define WBStatusSourceFont [UIFont systemFontOfSize:12]
// 正文的字体
#define WBStatusContentFont [UIFont systemFontOfSize:13]

// 被转发微博昵称字体
#define WBStatusRetweetNameFont [UIFont systemFontOfSize:15]
// 被转发微博正文的字体
#define WBStatusRetweetContentFont [UIFont systemFontOfSize:13]

// table 的边框宽度
#define WBStatusTableBorder 5
// cell 的边框宽度
#define WBStatusCellBorder 8

// titlebutton 宽度
#define TitleButtonimageWidth 20

// detail toolbar 高度
#define DetailToolBarHeight 40
// 被转发微博的toolbar 高度
#define RetweetedToolBarHeight 35





