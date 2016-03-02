//
//  WFWebView.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-15.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFAsyncHttp.h"

#pragma mark - ************************  WFWebView ************************
@class WFWebViewURLStringStack;
@interface WFWebView : UIWebView

@property (strong, nonatomic) void(^requestStartBlock)(void);

/*** 地址容器 ***/
@property (strong, nonatomic) WFWebViewURLStringStack *urlStringStack;

/*** 当前请求地址 ***/
@property (strong, nonatomic) NSString *currentRequestURLString;

/*** call when call [self.webView loadHTMLString:... baseURL:self.baseURL]; ***/
@property (strong, nonatomic) NSURL *baseURL;

/**
 *  请求网页数据（注意只有走这个请求才会缓存网页，如果走UIwebview自身请求，则不缓存）
 *
 *  @param URLString 请求地址
 */
- (void)requestWihtURLString:(NSString *)URLString baseURL:(NSURL *)baseURL andCachePolicy:(WFAsyncCachePolicy)cachePolicy;

- (void)destoryAll;

@end

#pragma mark - ************************  WFWebViewURLStringStack ************************
@interface WFWebViewURLStringStack : NSObject

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger currentIndex;

- (void)pushWithKey:(NSString *)key;

- (NSString *)pop;

- (BOOL)isEmpty;



@end
