//
//  AsyncViewController.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "AsyncViewController.h"
#import "WFAsyncHttp.h"
#import "AppDelegate.h"

@interface AsyncViewController ()

@property (strong, nonatomic) UIButton *btnGET;
@property (strong, nonatomic) UIButton *btnPOST;


@end

@implementation AsyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.btnGET = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnGET setTitle:@"GET_Async" forState:UIControlStateNormal];
    self.btnGET.backgroundColor = [UIColor blackColor];
    [self.btnGET addTarget:self action:@selector(testGET) forControlEvents:UIControlEventTouchUpInside];
    self.btnGET.frame = CGRectMake(10, 100, 100, 30);
    [self.view addSubview:self.btnGET];
    
    self.btnPOST = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnPOST setTitle:@"POST_Async" forState:UIControlStateNormal];
    self.btnPOST.backgroundColor = [UIColor blackColor];
    [self.btnPOST addTarget:self action:@selector(testPOST) forControlEvents:UIControlEventTouchUpInside];
    self.btnPOST.frame = CGRectMake(200, 100, 100, 30);
    [self.view addSubview:self.btnPOST];
    
//    [self testGET];
//    [self testPOST];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testGET
{
    [WFAsyncHttpManager GET_WithURLString:@"http://gc.ditu.aliyun.com/regeocoding?l=39.938133,116.395739&type=001"
                               andHeaders:nil
                           andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                               andSuccess:^(id responseObject)
    {
        [AppDelegate showLog:responseObject];
        [AppDelegate showAlert:@"WFAsyncHttpManager - GET异步方式 -> 离线成功"];
    } andFailure:^(NSError *error) {
        [AppDelegate showLog:@"WFAsyncHttpManager - GET异步方式 -> 离线失败"];
    }];
}

- (void)testPOST
{
    [WFAsyncHttpManager POST_WithURLString:@"https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=json%E5%9C%A8%E7%BA%BF%E8%A7%A3%E6%9E%90&rsv_pq=827e6055000126c3&rsv_t=7eef1BgWJhIzUhSdAm%2FO7GzHKx8p3KxecQuAYGRHPE0fih%2FTqSb2L%2FNPLTA&rsv_enter=1&rsv_sug3=4&rsv_sug1=2&sug=json%E5%9C%A8%E7%BA%BF%E8%A7%A3%E6%9E%90&rsv_n=1"
                                 andParams:nil
                                andHeaders:nil
                            andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad andSuccess:^(id responseObject)
    {
        [AppDelegate showLog:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        [AppDelegate showAlert:@"WFAsyncHttpManager - POST异步方式 -> 离线成功"];
    } andFailure:^(NSError *error) {
         [AppDelegate showLog:@"WFAsyncHttpManager - POST异步方式 -> 离线失败"];
    }];
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
