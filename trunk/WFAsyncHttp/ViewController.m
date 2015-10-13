//
//  ViewController.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "ViewController.h"
#import "WFAsyncHttp.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testAsync];
    //    [self testSystemAsync];
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
    [WFAsyncHttpManager GET_WithURLString:@"http://www.baidu.com" andHeaders:nil andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad andSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } andFailure:^(NSError *error) {
        
    }];
    
//    [WFAsyncHttpClient System_POST_WithURLString:@"http://www.baidu.com" andSuccess:^(id responseObject) {
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } andFailure:^(NSError *error) {
//        
//    }];
//    [WFAsyncHttpManager POST_WithURLString:@"http://pic002.cnblogs.com/images/2012/423466/2012072010285994.png"
//                                 andParams:nil
//                                andHeaders:nil
//                            andCachePolicy:WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet
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
