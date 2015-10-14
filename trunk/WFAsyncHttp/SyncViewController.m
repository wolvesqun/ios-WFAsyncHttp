//
//  SyncViewController.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "SyncViewController.h"
#import "WFAsyncHttp.h"
#import "AppDelegate.h"

@interface SyncViewController ()

@property (strong, nonatomic) UIButton *btnGET;
@property (strong, nonatomic) UIButton *btnPOST;

@end

@implementation SyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.btnGET = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnGET setTitle:@"GET_Sync" forState:UIControlStateNormal];
    self.btnGET.backgroundColor = [UIColor blackColor];
    [self.btnGET addTarget:self action:@selector(testGET) forControlEvents:UIControlEventTouchUpInside];
    self.btnGET.frame = CGRectMake(10, 100, 100, 30);
    [self.view addSubview:self.btnGET];
    
    self.btnPOST = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnPOST setTitle:@"POST_Sync" forState:UIControlStateNormal];
    self.btnPOST.backgroundColor = [UIColor blackColor];
    [self.btnPOST addTarget:self action:@selector(testPOST) forControlEvents:UIControlEventTouchUpInside];
    self.btnPOST.frame = CGRectMake(200, 100, 100, 30);
    [self.view addSubview:self.btnPOST];
    
}

- (void)testGET
{
    [WFSyncHttpClient System_GET_WithURLString:@"http://baike.baidu.com/link?url=KeukH7mzl7OU8wxXdSB9AZZffLqntSE_3y8--JjoPrbIVNTu4InEIKxJ8M-PgOiZOFevStVSM21y7uOh0E8RpK"
                                     andParams:nil
                                    andHeaders:nil
                                andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                                    andSuccess:^(id responseObject)
     {
        [AppDelegate showLog:responseObject];
        [AppDelegate showAlert:@"WFSyncHttpClient - GET同步方式 -> 离线成功"];
    } andFailure:^(NSError *error) {
        [AppDelegate showLog:@"WFSyncHttpClient - GET异步方式 -> 离线失败"];
    }];
   
}

- (void)testPOST
{
    [WFSyncHttpClient System_POST_WithURLString:@"http://baike.baidu.com/link?url=KeukH7mzl7OU8wxXdSB9AZZffLqntSE_3y8--JjoPrbIVNTu4InEIKxJ8M-PgOiZOFevStVSM21y7uOh0E8RpK" andParams:nil
                                     andHeaders:nil
                                 andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                                     andSuccess:^(id responseObject)
    {
        [AppDelegate showLog:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        [AppDelegate showAlert:@"WFSyncHttpClient - POST同步方式 -> 离线成功"];
        
    } andFailure:^(NSError *error)
    {
        [AppDelegate showLog:@"WFSyncHttpClient - POST同步方式 -> 离线失败"];
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
