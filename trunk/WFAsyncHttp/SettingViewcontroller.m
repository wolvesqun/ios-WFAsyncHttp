//
//  SettingViewcontroller.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-16.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "SettingViewcontroller.h"
#import "WFAsyncHttp.h"
#import "AppDelegate.h"

@interface SettingViewcontroller ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation SettingViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"remove all cache | 删除所有缓存",
                      @"remove Image cache | 删除所有图片缓存",
                      @"remove web cache (js,css) | 删除所有css,js ...缓存",
//                      @"remove al",
                      nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
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
        [WFAsyncHttpCacheManager removeAllCache];
    }
    else if (indexPath.row == 1)
    {
        [WFAsyncHttpCacheManager removeAllImageCache];
    }
    else if (indexPath.row == 2)
    {
        [WFAsyncHttpCacheManager removeAllWebCache];
    }
    [AppDelegate showAlert:@"delete cache success"];
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
