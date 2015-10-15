//
//  WebviewCacheVC.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WebviewCacheVC.h"
#import "WFAsyncHttp.h"

@interface WebviewCacheVC ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webview;

@end

@implementation WebviewCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webview.delegate = self;
    self.webview.scalesPageToFit = YES;
    [self.view addSubview:self.webview];
   
#warning 网页要缓存必须使用这个请求方式， 而且还要在设置AppDelegate里 设置 [WFAsyncURLCache setURLCache]; | 不支持  [self.webview loadRequest:...];
    [WFAsyncHttpManager GET_WithURLString:@"https://www.baidu.com/" andHeaders:nil
                        andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                            andSuccess:^(id responseObject)
    {
        
        [self.webview loadData:responseObject MIMEType:nil textEncodingName:nil baseURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
        
    } andFailure:^(NSError *error)
     {
         NSLog(@"webview load error ------------------");
    }];
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
