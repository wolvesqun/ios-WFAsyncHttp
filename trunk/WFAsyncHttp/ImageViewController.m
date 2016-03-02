//
//  ImageViewController.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "ImageViewController.h"
//#import "UIImageView+WFImageViewCache.h"
#import "WFAsyncHttpCacheManager.h"

@interface ImageViewController ()

@property (strong, nonatomic) UIButton *btnImage;

@property (strong, nonatomic) UIImageView *img;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnImage setTitle:@"离线图片" forState:UIControlStateNormal];
    self.btnImage.backgroundColor = [UIColor blackColor];
    [self.btnImage addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    self.btnImage.frame = CGRectMake(100, 100, 100, 30);
    [self.view addSubview:self.btnImage];
    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    self.img.center = CGPointMake(self.view.frame.size.width / 2, self.img.center.y);
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.img];
    
    [self _initNav];
}

- (void)_initNav
{
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"删除图片缓存" style:UIBarButtonItemStyleDone target:self action:@selector(tapActionRight)];
    self.navigationItem.rightBarButtonItem = btnRight;
}

- (void)tapActionRight
{
    // *** 删除单张图片缓存
//    [self.img removeCache:@"http://d.hiphotos.baidu.com/image/w%3D310/sign=d12bf5db19d5ad6eaaf962ebb1cb39a3/b64543a98226cffc1d2771adbb014a90f603eaa4.jpg"];
//    self.img.image = nil;
    
    // *** 删除所有图片缓存
    //  [WFAsynHttpCacheManager removeAllImageCache];
}

- (void)tapAction
{
//    [self.img setImageWithKey:@"http://d.hiphotos.baidu.com/image/w%3D310/sign=d12bf5db19d5ad6eaaf962ebb1cb39a3/b64543a98226cffc1d2771adbb014a90f603eaa4.jpg"
//             placeholderImage:nil
//                   andSuccess:^(UIImage *image)
//     {
//        
//    } andFailure:^(NSError *error) {
//        
//    }];
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
