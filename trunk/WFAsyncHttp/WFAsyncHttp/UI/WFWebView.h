//
//  WFWebView.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-15.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFAsyncHttp.h"

#pragma mark - ************************  WFWebViewURLStringStack ************************
@interface WFWebViewURLStringStack : NSObject

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger currentIndex;

- (void)pushWithKey:(NSString *)key;

- (NSString *)pop;

- (BOOL)isEmpty;



@end

#pragma mark - ==================================== UIWebView ====================================
@interface WFWebView : UIWebView

@property (strong, nonatomic) void(^BLock_requestStart)(void);
@property (strong, nonatomic) void(^BLock_requestFinish)(void);

/*** 地址容器 ***/
@property (strong, nonatomic, readonly) WFWebViewURLStringStack *urlStringStack;

/*** 当前请求地址 ***/
@property (strong, nonatomic, readonly) NSString *currentRequestURLString;

/*** call when call [self.webView loadHTMLString:... baseURL:self.baseURL]; ***/
@property (strong, nonatomic, readonly) NSURL *baseURL;

/*** 内存数据缓存失效时间,如果有设置内存缓存策略，并且expireTime<0，那么内存缓存就永久缓存，直到应用程序关闭 ***/
@property (assign, nonatomic) NSTimeInterval expireTime;

/**
 *  请求网页数据（注意只有走这个请求才会缓存网页，如果走UIwebview自身请求，则不缓存）
 *
 *  @param URLString 请求地址
 */
- (void)requestWihtURLString:(NSString *)URLString
                     baseURL:(NSURL *)baseURL
       andStorageCachePolicy:(WFStorageCachePolicy)sCachePolicy
           andMemCachePolicy:(WFMemCachePolicy)mCachePolicy;

- (void)destoryAll;

/**
 *  字符串替换
 */
- (void)replacingURLStackWithURLString:(NSString *)URLString andIndex:(NSInteger)index;

@end


