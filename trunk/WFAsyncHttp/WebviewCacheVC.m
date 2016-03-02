//
//  WebviewCacheVC.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WebviewCacheVC.h"
#import "WFAsyncHttp.h"
//#import "WFWebView.h"
#import "Toast.h"
#import "AppDelegate.h"

@interface WebviewCacheVC ()

//@property (strong, nonatomic) WFWebView *webview;

@end

@implementation WebviewCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    
//    [self testWebView1];
    [self testWebview2];
   
 
}

#warning 网页要缓存必须使用这个请求方式， 而且还要在设置AppDelegate里 设置 [WFAsyncURLCache setURLCache]; | 不支持  [self.webview loadRequest:...];


#pragma mark - 第一种网页缓存方式
- (void)testWebView1
{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    webview.scalesPageToFit = YES;
    [self.view addSubview:webview];
    [WFAsyncHttpManager GET_WithURLString:@"https://www.baidu.com/" andHeaders:nil
                           andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                               andSuccess:^(id responseObject, BOOL cache)
     {
         
         [webview loadData:responseObject MIMEType:nil textEncodingName:nil baseURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
         
     } andFailure:^(NSError *error)
     {
         NSLog(@"webview load error ------------------");
     }];
}

#pragma mark - 第二种方式
- (void)testWebview2
{
    self.webview = [[WFWebView alloc] initWithFrame:self.view.frame];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    self.webview.baseURL = [NSURL URLWithString:@"http://wapbaike.baidu.com/"];
    
    [self.webview loadWihtURLString:@"http://wapbaike.baidu.com/view/1088.htm"];
    
    
    UIButton *btnback = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnback setTitle:@"back" forState:UIControlStateNormal];
    btnback.backgroundColor = [UIColor blackColor];
    [btnback addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btnback.frame = CGRectMake(10, 100, 100, 30);
    [self.view addSubview:btnback];
}

- (void)webViewDidStartLoadData:(WFWebView *)myWebview
{
    [Toast showActivityIndicatorView];
}

/**
 *  当前请求缓存策略
 *
 *  @param URLString 请求地址
 *  @return 返回缓存策略 （默认 WFAsyncCachePolicyType_Default 不提供 ）
 */
- (WFAsyncCachePolicy)webView:(WFWebView *)webView cachePolicyWithURLString:(NSString *)URLString
{
    if([URLString rangeOfString:@"http://wapbaike.baidu.com"].length > 0)
    {
        return WFAsyncCachePolicyType_ReturnCache_DontLoad;
    }
    return WFAsyncCachePolicyType_Default;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLString = request.URL.absoluteString;
    if([URLString rangeOfString:@"http://wapbaike.baidu.com"].length > 0 && navigationType == UIWebViewNavigationTypeLinkClicked &&
       ![WFAsyncHttpUtil isImageRequest:URLString])
    {
        [self.webview loadWihtURLString:request.URL.absoluteString];
        return NO;
    }
    [Toast showActivityIndicatorView];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Toast dimissActivityIndicatorViewByMandatory];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [Toast dimissActivityIndicatorViewByMandatory];
}

- (void)back
{
    if([self.webview canGoBack])
    {
        [self.webview goBack];
    }
    else
    {
        [AppDelegate showAlert:@"无法回退了， "];
    }
    
}

//- (void)forward
//{
//    [self.webview goForward];
//}

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
