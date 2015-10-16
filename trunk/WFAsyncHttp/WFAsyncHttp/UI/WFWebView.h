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
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
/**
 *  装载网页数据start
 */
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

- (void)webViewDidStartLoadData:(WFWebView *)myWebview;

@required
/**
 *  当前请求缓存策略
 *  
 *  @param URLString 请求地址
 *  @return 返回缓存策略 （默认 WFAsyncCachePolicyType_Default 不提供 ）
 */
- (WFAsyncCachePolicy)webView:(WFWebView *)myWebview cachePolicyWithURLString:(NSString *)URLString;

@end

@interface WFWebView : UIView

@property (assign, nonatomic) id<WFWebViewDelegate> delegate;

@property (nonatomic, readonly, strong) UIScrollView *scrollView;

/*** 当前请求地址 ***/
@property (strong, nonatomic, readonly) NSString *currentRequestURLString;

/*** call when call [self.webView loadHTMLString:... baseURL:self.baseURL]; ***/
@property (strong, nonatomic) NSURL *baseURL;

/**
 *  请求网页数据（注意只有走这个请求才会缓存网页，如果走UIwebview自身请求，则不缓存）
 *
 *  @param URLString 请求地址
 */
- (void)loadWihtURLString:(NSString *)URLString;

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
