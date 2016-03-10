//
//  ListViewController.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/10.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "ListViewController.h"
#import "WFAsyncHttp.h"
#import "ArticleBean.h"
#import "Toast.h"

@interface ListViewController ()

@property (assign, nonatomic) BOOL bHeaderLoading;

@property (strong, nonatomic) NSMutableArray *dtArray;

@property (strong, nonatomic) UIButton *lastButton;
@property (strong, nonatomic) UIButton *nextButton;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.dtArray = [NSMutableArray array];
    
    self.lastButton = [self createButtonWithTitle:@"下拉刷新" andFrame:CGRectMake(20, 100, 100, 50)];
    
    self.nextButton = [self createButtonWithTitle:@"上拉加载更多" andFrame:CGRectMake(
                                               self.view.frame.size.width - 20 * 2 - 100,
                                                                                     100,
                                                                                     100,
                                                                                     50)];
    
}

- (UIButton *)createButtonWithTitle:(NSString *)title andFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
    return button;
}

- (void)tapAction:(UIButton *)sender
{
    if(sender == self.lastButton)
    {
        self.bHeaderLoading = YES;
    }
    else
    {
        self.bHeaderLoading = NO;
    }
     [self requestStartUsingCacheFirst];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// httpp://ipadnews.caijing.com.cn/api/1.0/articles.php?
// 列表缓存，只缓存第一次，以后都不缓存
- (void)requestStartUsingCacheFirst
{
    [self setUserEnable:NO];
    
 
    NSString *URLString = [NSString stringWithFormat:@"http://ipadnews.caijing.com.cn/api/1.0/articles.php?columnid=886&page=%d&pagesize=10&action=articlelist&bundleId=cn.com.caijing.ipaddigimag&platform=iOS9.200000&appVer=3.54&network=wifi",(int)(self.dtArray.count + 10)/10];

    
    [WFRequestManager GET_UsingMemCache_WithURLString:URLString
                                            andHeader:nil
                                         andUserAgent:nil
                                        andExpireTime:60
                                       andCachePolicy:self.dtArray.count == 0 ? WFMemCachePolicyType_ReturnCache_ElseLoad : WFMemCachePolicyType_Default
                                           andSuccess:^id(id responseDate, NSURLResponse *response, BOOL isCache)
    {
        NSArray *tempArray = responseDate;
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:tempArray.count];
        for (NSDictionary *dict in tempArray) {
            [dataArray addObject:[ArticleBean beanWithDict:dict]];
        }
        
        [self requestFinishSuccess:dataArray];
        return nil;
    } andFailure:^(NSError *error)
     {
         [self requestFinishError:error];
    }];
}

- (void)requestFinishSuccess:(NSMutableArray *)dataArray
{
    // *** 1. 判断
    if(self.bHeaderLoading)
    {
        [self.dtArray removeAllObjects];
    }
    
    // *** 2. 添加数据
    [self.dtArray addObjectsFromArray:dataArray];
    
    // *** 3. 更新UI
    // [tableview reloadData]
    if(self.bHeaderLoading)
    {
        NSLog(@"========= 下拉刷新 获取了 %d 条数据, 现在共有 %d 数据", (int)dataArray.count, (int)self.dtArray.count);
    }
    else
    {
        NSLog(@"========= 上拉加载了 %d 条数据, 现在共有 %d 数据", (int)dataArray.count, (int)self.dtArray.count);
    }
    
    
    // *** 4. 结束刷新
    //  [刷新控件 endRefresh]
    
    // *** 5. 开启交互
    [self setUserEnable:YES];
}

- (void)requestFinishError:(NSError *)error
{
    // *** 1. 提示错误
    // *** 2. 如果没有当前数据就出现没有数据的和谐图
    // *** 3. 结束刷新
    // *** 4. 开启交互
    [self setUserEnable:YES];
}

- (void)setUserEnable:(BOOL)enable
{
    self.view.userInteractionEnabled = enable;
    self.navigationController.view.userInteractionEnabled = enable;
    if(!enable)
    {
        [Toast showActivityIndicatorView];
    }
    else
    {
        [Toast dimissActivityIndicatorViewByMandatory];
    }
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
