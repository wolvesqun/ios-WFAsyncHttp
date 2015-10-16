//
//  WFWebView.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-15.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFWebView.h"
#import "WFAsyncHttp.h"

// ****************************************************************************************************************************
@interface WFWebViewURLStringStack : NSObject

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger currentIndex;

- (void)pushWithKey:(NSString *)key;

- (NSString *)pop;


- (BOOL)isEmpty;

@end


@implementation WFWebViewURLStringStack

- (instancetype)init
{
    if(self = [super init])
    {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)pushWithKey:(NSString *)key
{
    if(key && key.length > 0)
    {
        [self.dataArray addObject:key];
    }
    
}

- (NSString *)pop
{
    //    if(self.dataArray.count )
    NSString *key = nil;
    if(![self isEmpty])
    {
        
        key = [self.dataArray objectAtIndex:self.dataArray.count - 2];
        [self.dataArray removeLastObject];
    }
    
    return key;
}

- (BOOL)isEmpty
{
    return self.dataArray.count <= 1;
}

- (void)removeAllObj
{
    [self.dataArray removeAllObjects];
}

@end

// ****************************************************************************************************************************

@interface WFWebView ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

/*** http请求 ***/
@property (strong, nonatomic) WFAsyncHttpClient *httpClient;

@property (strong, nonatomic) WFWebViewURLStringStack *urlStringStack;

@property (strong, nonatomic) NSURL *baseURL;

@end


@implementation WFWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.urlStringStack = [WFWebViewURLStringStack new];
        
        self.httpClient = [[WFAsyncHttpClient alloc] init];
        
        self.webView = [[UIWebView alloc] initWithFrame:frame];
        self.webView.delegate = self;
        [self addSubview:self.webView];
    }
    return self;
}

#pragma mark - start request
- (void)loadWihtURLString:(NSString *)URLString andBaseURL:(NSURL *)baseURL
{
    [self loadWihtURLString:URLString andBaseURL:baseURL andBPush:YES];
}

- (void)loadWihtURLString:(NSString *)URLString andBaseURL:(NSURL *)baseURL andBPush:(BOOL)bPush
{
    if(bPush)
    {
        [self.urlStringStack pushWithKey:URLString];
    }
    _currentRequestURLString = URLString;
    
    [self.httpClient setCachePolicy:[self.delegate webView:self cachePolicyWithURLString:URLString]];
    self.baseURL = baseURL;
    [self.httpClient GET_WithURLString:URLString andSuccess:^(id responseObject)
     {
         [self.webView loadHTMLString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] baseURL:self.baseURL];
     } andFailure:^(NSError *error) {
         [self webView:self.webView didFailLoadWithError:error];
     }];
   
}

- (void)handleLinkedWithURLString:(NSString *)URLString
{
    NSString *temp = [self.delegate webView:self showStartLoadWhenClickWithURLString:URLString];
    if(temp)
    {
        URLString = temp;
    }
    
    [self loadWihtURLString:URLString andBaseURL:self.baseURL];
}

#pragma mark - webview common method
- (void)reload
{
    if(self.currentRequestURLString && self.currentRequestURLString.length > 0)
    {
        [self loadWihtURLString:self.currentRequestURLString andBaseURL:self.baseURL andBPush:NO];
    }
    
}

- (UIScrollView *)scrollView
{
    return self.webView.scrollView;
}

- (void)stopLoading
{
    [self.httpClient cancel];
    [self.webView stopLoading];
}

- (void)goBack
{
    if([self canGoBack])
    {
        NSString *URLString = [self.urlStringStack pop];
        [self loadWihtURLString:URLString andBaseURL:self.baseURL andBPush:NO];
    }
}


- (BOOL)canGoBack
{
    return ![self.urlStringStack isEmpty];
}

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script
{
    return [self.webView stringByEvaluatingJavaScriptFromString:script];
}

- (void)setScalesPageToFit:(BOOL)scalesPageToFit
{
    [self.webView setScalesPageToFit:scalesPageToFit];
}
- (BOOL)scalesPageToFit
{
    return self.webView.scalesPageToFit;
}

#pragma mark - 网页回调代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLString = request.URL.absoluteString;
    if(![self.delegate webView:self canHandleLinkedWithURLString:URLString] && navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [self handleLinkedWithURLString:URLString];
        return NO;
    }
    
    if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) // 实现
    {
        return [self.delegate webView:self.webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [self.delegate webViewDidStartLoad:self.webView];
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [self.delegate webViewDidFinishLoad:self.webView];
    }
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [self.delegate webView:self.webView didFailLoadWithError:error];
    }
}




@end
