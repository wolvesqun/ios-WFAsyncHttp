//
//  WebViewController.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/15.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "WebViewController.h"
#import "WFWebView.h"
#import "Toast.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) WFWebView *webview;

@property (strong, nonatomic) NSURL *baseURL;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initNav];
    
    [self _initCtrl];
}

- (void)_initNav
{
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(actionToBack)];
    self.navigationItem.leftBarButtonItem = btnBack;
}

- (void)_initCtrl
{
    self.baseURL = [NSURL URLWithString:@"http://wapbaike.baidu.com"];
    self.webview = [[WFWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.webview.delegate = self;
    self.webview.expireTime = 0; // 默认也是0
    [self.view addSubview:self.webview];
    [self requestWithURLString:@"http://wapbaike.baidu.com/view/1796745.htm"];
}

- (void)actionToBack
{
    if([self.webview canGoBack])
    {
        [self.webview goBack];
    }
    else
    {
        // 注意：退出的时候一定要在这里写，如果写在viewDidDisappear,那么你要确定这里就是关闭了，而不是去其它页，比如你的应用还有search功能，所以要么自定义返回键，要么监听返回键事件
        [self.webview destoryAll];
        [self.navigationController popViewControllerAnimated:YES];
        [Toast dimissActivityIndicatorViewByMandatory];
    }
    
}

#pragma mark - webview 生命周期
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLString = request.URL.absoluteString;
    if(navigationType == UIWebViewNavigationTypeLinkClicked && [URLString rangeOfString:@"http://wapbaike.baidu.com"].length > 0)
    {
        NSRange range = [URLString rangeOfString:@"?"];
        URLString = [URLString substringToIndex:range.location];
        [self requestWithURLString:URLString];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Toast dimissActivityIndicatorViewByMandatory];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - 请求
- (void)requestWithURLString:(NSString *)URLString
{
    [Toast showActivityIndicatorView];
    [self.webview requestWihtURLString:URLString
                               baseURL:self.baseURL
                 andStorageCachePolicy:WFStorageCachePolicyType_ReturnCache_ElseLoad // 本地缓存策略
                     andMemCachePolicy:WFMemCachePolicyType_ReturnCache_ElseLoad]; // 内存缓存策略
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
