//
//  ViewController.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "ViewController.h"
#import "WFAsyncHttp.h"
#import "AsyncHttpViewController.h"
//#import "SyncViewController.h"
//#import "WebviewCacheVC.h"
//#import "ImageViewController.h"
#import "SettingViewcontroller.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIWebView *webview;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initNav];

    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"异步请求 -> Async Request",
//                      @"同步请求 -> Sync Request",
//                      @"网页请求 -> webview request Cache",
//                      @"图片请求 -> Image request Cache",
                      nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)_initNav
{
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"Setting" style:UIBarButtonItemStyleDone target:self action:@selector(pushSettingVC)];
    self.navigationItem.rightBarButtonItem = btnRight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_Reuse"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_Reuse"];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [self.navigationController pushViewController:[AsyncHttpViewController new] animated:YES];
    }
    else if (indexPath.row == 1)
    {
//        [self.navigationController pushViewController:[SyncViewController new] animated:YES];
    }
    else if (indexPath.row == 2)
    {
//        [self.navigationController pushViewController:[WebviewCacheVC new] animated:YES];
    }
    else if (indexPath.row == 3)
    {
//        [self.navigationController pushViewController:[ImageViewController new] animated:YES];
    }
    // http://apis.baidu.com/tngou/drug/list?id=0&page=1&rows=20&appkey=c565603b40c205fab6078493cb16864d
}

- (void)pushSettingVC
{
    [self.navigationController pushViewController:[SettingViewcontroller new] animated:YES];
}

- (void)test
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
