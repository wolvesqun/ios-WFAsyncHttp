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

@property (strong, nonatomic) NSDate *startDate;

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
    
    self.startDate = [NSDate date];
    NSString *URLString = [NSString stringWithFormat:@"http://www.mbalib.com/appwiki/article?num=10&offset=%d",(int)self.dtArray.count];
    [WFRequestManager GET_UsingMemCache_WithURLString:URLString
                                            andHeader:nil
                                         andUserAgent:nil
                                     andStoragePolicy:self.bHeaderLoading ? WFStorageCachePolicyType_ReturnCache_DidLoad : WFStorageCachePolicyType_Default
                                        andExpireTime:60
                                    andMemCachePolicy:WFMemCachePolicyType_ReturnCache_ElseLoad
                                           andSuccess:^id(id responseDate, NSURLResponse *response, BOOL isCache)
    {
        NSArray *tempArray = responseDate;
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:tempArray.count];
        for (NSDictionary *dict in tempArray) {
            [dataArray addObject:[ArticleBean beanWithDict:dict]];
        }
        
        [self requestFinishSuccess:dataArray];
        return nil;

    } andFailure:^(NSError *error) {
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
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.startDate];
    if(self.bHeaderLoading)
    {
        NSLog(@"========= 下拉刷新 获取了 %2d 条数据, 现在共有 %2d 数据, 耗时 %f", (int)dataArray.count, (int)self.dtArray.count, time);
    }
    else
    {
        NSLog(@"========= 上拉加载了 %2d 条数据, 现在共有 %2d 数据,     耗时 %f", (int)dataArray.count, (int)self.dtArray.count, time);
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
