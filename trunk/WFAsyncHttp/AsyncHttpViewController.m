//
//  AsyncHttpViewController.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/10.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "AsyncHttpViewController.h"
#import "WFAsyncHttp.h"

@interface AsyncHttpViewController ()
@property (strong, nonatomic) NSDate *startDate;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;

@end

@implementation AsyncHttpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)startLoad:(id)sender {
    self.view.userInteractionEnabled = NO;
    static int index = 1;
    self.startDate = [NSDate date];
    [WFRequestManager GET_UsingMemCache_WithURLString:@"http://imgsrc.baidu.com/baike/pic/item/b13fd4808a7d68eb9123d9a7.jpg"
                                            andHeader:nil
                                         andUserAgent:nil
                                        andExpireTime:10 // 设置内存缓存时间10秒
                                       andCachePolicy:WFMemCachePolicyType_ReturnCache_ElseLoad
                                           andSuccess:^id(id responseData, NSURLResponse *response, BOOL isCache)
     {
        
         
         NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.startDate];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *timeText = [NSString stringWithFormat:@"用时 ：%f",time];
             
             NSLog(@"======== 第%2d次请求用时： %@",index,  timeText);
             index ++;
             
             self.view.userInteractionEnabled = YES;
         });
         
         return responseData; // 返回要缓存的数据, 如果是json数据，请处理后的数据返回来
    } andFailure:^(NSError *error) {
        
    }];
}

#pragma mark - post 请求
- (void)testPOST
{
    [WFRequestManager POST_UsingMemCache_WithURLString:@"http://imgsrc.baidu.com/baike/pic/item/b13fd4808a7d68eb9123d9a7.jpg"
                                             andHeader:nil
                                          andUserAgent:nil
                                              andParam:nil
                                         andExpireTime:60 * 10
                                        andCachePolicy:WFMemCachePolicyType_ReturnCache_ElseLoad andSuccess:^id(id responseDate, NSURLResponse *response, BOOL isCache)
    {
        return responseDate;
    } andFailure:^(NSError *error)
    {
        
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
