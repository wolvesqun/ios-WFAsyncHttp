//
//  Toast.m
//  wiki
//
//  Created by mba on 14-5-30.
//  Copyright (c) 2014年 mbalib. All rights reserved.
//

/*** 设备宽高 ***/
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height

/*** toast宽高 ***/
#define TOAST_WIDTH 100
#define TOAST_HEIGHT 45

#define TOAST_ACTIVITY_INDICATORY_VIEW_SIZE 80

//从上方显示
//提示视图高度
#define ALERT_VIEW_HEIGHT 64
#define ALERT_TEXT_FONT 17
//动画时间
#define ALERT_VIEW_ANIMATION_TIME 0.7
//停顿时间
#define ALERT_SHOW_TIME 1.5


#import "Toast.h"

@implementation Toast

/*** window ***/
static UIWindow *window;

/*** toast背景图 ***/
static UIView *bgViewToast;

/*** 显示文本 ***/
static UILabel *lbTextToast;

/*** 菊花视图 ***/
static UIActivityIndicatorView *activityIndicatorView;

/*** 菊花引用计数 ***/
static NSInteger activityIndicatorViewUsedCount = 0;

#pragma mark - 获取系统window
+ (UIWindow *) getWindow {
    if(window == nil) {
        // *** 获取window
        window = [UIApplication sharedApplication].keyWindow;
        [window makeKeyAndVisible];
    }
    return window;
}



#pragma mark - 隐藏显示框
+(void)dismiss {
    
    [UIView animateWithDuration:1.0f animations:^{
        // *** 隐藏bgViewToast
        bgViewToast.alpha = 0;
        
    } completion:^(BOOL finished) {
        [bgViewToast removeFromSuperview];
    }];
    
//    [JCProgressHUD dismiss];
}

#pragma mark - 菊花加载中提示
+ (void)showActivityIndicatorView {
    
    if(activityIndicatorView == nil) {
        // *** 初始化菊花视图
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        // *
        activityIndicatorView.backgroundColor = [UIColor blackColor];
        activityIndicatorView.frame = CGRectMake((DEVICE_WIDTH - TOAST_ACTIVITY_INDICATORY_VIEW_SIZE) / 2, (DEVICE_HEIGHT - TOAST_ACTIVITY_INDICATORY_VIEW_SIZE) / 2, TOAST_ACTIVITY_INDICATORY_VIEW_SIZE + 20, TOAST_ACTIVITY_INDICATORY_VIEW_SIZE);
        activityIndicatorView.center = [Toast getWindow].center;
        activityIndicatorView.layer.cornerRadius = 10;
        activityIndicatorView.alpha = 0;
    }
    
    if(activityIndicatorViewUsedCount == 0) {
        // *** 添加
        [[Toast getWindow] addSubview:activityIndicatorView];
    }
    
    // *** 菊花引用计数 + 1
    activityIndicatorViewUsedCount ++;
    
    // *** 开启动画
    if(![activityIndicatorView isAnimating]) {
        //        NSLog(@"start ++ ----------- %d", activityIndicatorViewUsedCount);
        activityIndicatorView.alpha = 0.5;
        [activityIndicatorView startAnimating];
    }
    
    
//    [JCProgressHUD show];
}

#pragma mark - 菊花加载 停止
+ (void)dimissActivityIndicatorView {
    
    if(activityIndicatorViewUsedCount == 0) return;
    
    // *** 菊花引用计数 - 1
    activityIndicatorViewUsedCount --;
    
    // *** 停止动画
    if(activityIndicatorViewUsedCount <= 0) {
        //        NSLog(@"dismiss ----------- %d", activityIndicatorViewUsedCount);
        [UIView animateWithDuration:1.0 animations:^{
            activityIndicatorView.alpha = 0;
        } completion:^(BOOL finished) {
            [activityIndicatorView stopAnimating];
            [activityIndicatorView removeFromSuperview];
            
        }];
    }
    
    
//    [JCProgressHUD dismiss];
}

#pragma mark - 强制停止菊花转动
+ (void)dimissActivityIndicatorViewByMandatory {
    if(activityIndicatorViewUsedCount == 0) return;
    
    activityIndicatorViewUsedCount = 0;
    activityIndicatorView.alpha = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [activityIndicatorView stopAnimating];
        [activityIndicatorView removeFromSuperview];
       
    });
    
    
//    [JCProgressHUD dismiss];
}

@end
