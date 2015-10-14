//
//  ViewController.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "ViewController.h"
#import "WFAsyncHttp.h"

@interface ViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testWeb];
//    [self testAsync];
    //    [self testSystemAsync];
}

- (void)testWeb
{
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.webview.delegate = self;
    self.webview.scalesPageToFit = YES;
    [self.view addSubview:self.webview];
    
    [WFAsyncHttpManager GET_WithURLString:@"http://wiki.mbalib.com/wiki/2015%E5%B9%B4%E8%AF%BA%E8%B4%9D%E5%B0%94%E7%BB%8F%E6%B5%8E%E5%AD%A6%E5%A5%96?app=1" andHeaders:nil andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad andSuccess:^(id responseObject) {
        [self.webview loadData:responseObject MIMEType:nil textEncodingName:nil baseURL:[NSURL URLWithString:@"http://wiki.mbalib.com/"]];
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)testSystemAsync
{
    //    [WFAsyncHttpClient System_GET_WithURLString:@"https://www.baidu.com" andHeaders:nil andCachePolicy:WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet andSuccess:^(id responseObject) {
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
    //
    //    [WFAsyncHttpClient System_POST_WithURLString:@"https://www.baidu.com" andParams:nil andHeaders:nil andCachePolicy:WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet andSuccess:^(id responseObject) {
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
}


- (void)testAsync
{
//    [WFAsyncHttpClient System_GET_WithURLString:@"http://pic002.cnblogs.com/images/2012/423466/2012072010285994.png" andSuccess:^(id responseObject) {
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } andFailure:^(NSError *error) {
//        
//    }];
//    [WFAsyncHttpManager GET_WithURLString:@"http://pic002.cnblogs.com/images/2012/423466/2012072010285994.png" andHeaders:nil andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad andSuccess:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//    } andFailure:^(NSError *error) {
//        
//    }];
    
//    [WFAsyncHttpClient System_POST_WithURLString:@"http://www.baidu.com" andSuccess:^(id responseObject) {
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } andFailure:^(NSError *error) {
//        
//    }];
//    [WFAsyncHttpManager POST_WithURLString:@"http://pic002.cnblogs.com/images/2012/423466/2012072010285994.png"
//                                 andParams:@{@"1":@"1"}
//                                andHeaders:nil
//                            andCachePolicy:WFAsyncCachePolicyType_Default
//                                andSuccess:^(id responseObject)
//     {
//         NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//     } andFailure:^(NSError *error) {
//         
//     }];
    //    [WFAsyncHttpManager GET_WithURLString:@"https://www.baidu.com/" andHeaders:nil andCachePolicy:WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet
    //                               andSuccess:^(id responseObject)
    //    {
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    } ];
    
    //    NSString *URLString = @"http://www.dev.mbalib.com/appwiki/test2?user=u1&password=p1";
    //    [WFAsyncHttpManager GET_WithURLString:URLString andUserAgent:@"Good" andSuccess:^(id responseObject) {
    //
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
    //
    //    [WFAsyncHttpManager GET_WithURLString:@"http://www.dev.mbalib.com/appwiki/test2?password=p1" andHeaders:@{@"user":@"daf"} andSuccess:^(id responseObject) {
    //         NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
    //
    //    [WFAsyncHttpManager POST_WithURLString:URLString andSuccess:^(id responseObject) {
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
    //
//        [WFAsyncHttpManager POST_WithURLString:@"http://www.baidu.com"
//                                     andParams:@{@"pp":@"pp"}
//                                    andHeaders:@{@"uu":@"uu"}
//                                    andSuccess:^(id responseObject) {
//            NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        } andFailure:^(NSError *error) {
//    
//        }];
    //
    //    [WFAsyncHttpManager POST_WithURLString:URLString andParams:nil andUserAgent:@"fasdjf;" andSuccess:^(id responseObject) {
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
    
    //    [WFAsyncHttpManager POST_WithURLString:URLString andParams:@{@"pp" : @"pp"} andSuccess:^(id responseObject) {
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
    
}

- (void)testSync
{
    NSString *URLString = @"http://www.dev.mbalib.com/appwiki/test2?user=u1&password=p1";
    //    [WFSyncHttpClient System_POST_WithURLString:URLString andParams:@{@"pp":@"pp"} andHeaders:@{@"dd":@"dd"} andSuccess:^(id responseObject) {
    //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //    } andFailure:^(NSError *error) {
    //
    //    }];
    [WFAsyncHttpClient System_GET_WithURLString:@"http://www.baidu.com/"
                                     andHeaders:nil
                                 andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                                     andSuccess:^(id responseObject)
    {
        
    } andFailure:^(NSError *error) {
        
    }];
    
    [WFSyncHttpClient System_POST_WithURLString:URLString
                                      andParams:nil
                                   andUserAgent:@"sadfa;sdjfa;sdjk"
                                     andSuccess:^(id responseObject) {
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
