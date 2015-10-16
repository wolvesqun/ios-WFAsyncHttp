//
//  WFWebView.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-15.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFAsyncHttp.h"

@class WFWebView;
@protocol WFWebViewDelegate <NSObject>

@optional
/**
 *  the method will call when the method which is "- (BOOL)webView:(WFWebView *)webView canHandleLinkedWithURLString:(NSString *)URLString" will return YES;
 */
- (BOOL)webView:(WFWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(WFWebView *)webView;
- (void)webViewDidFinishLoad:(WFWebView *)webView;
- (void)webView:(WFWebView *)webView didFailLoadWithError:(NSError *)error;

#warning 以下不实现将报错
@required
/**
 *  是否要处理此网页链接请求
 *  
 *  @param URLString 网页链接
 *
 *  @return YES -》自已处理 | NO -》交由框架处理
 */
- (BOOL)webView:(WFWebView *)webView canHandleLinkedWithURLString:(NSString *)URLString;

/**
 *  根据给定点击网页链接地址进行修改再发起请求（如何不实现就默认网页原链接）
 *
 *  @param linkedURLString 网页链接地址
 *  @return 返回请求地址
 */
- (NSString *)webView:(WFWebView *)webView showStartLoadWhenClickWithLinkedURLString:(NSString *)linkedURLString;

/**
 *  当前请求缓存策略
 *  
 *  @param URLString 请求地址
 *  @return 返回缓存策略 （默认 WFAsyncCachePolicyType_Default 不提供 ）
 */
- (WFAsyncCachePolicy)webView:(WFWebView *)webView cachePolicyWithURLString:(NSString *)URLString;

@end

@interface WFWebView : UIView

@property (assign, nonatomic) id<WFWebViewDelegate> delegate;

@property (nonatomic, readonly, strong) UIScrollView *scrollView;

/*** 当前请求地址 ***/
@property (strong, nonatomic, readonly) NSString *currentRequestURLString;

- (void)loadWihtURLString:(NSString *)URLString andBaseURL:(NSURL *)baseURL;

#pragma mark - webview common method
- (void)reload;
- (void)stopLoading;

- (void)goBack;
//- (void)goForward;

@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
//@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;

@property (nonatomic) BOOL scalesPageToFit;

@end
