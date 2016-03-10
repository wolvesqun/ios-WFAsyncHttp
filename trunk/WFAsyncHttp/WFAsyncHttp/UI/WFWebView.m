//
//  WFWebView.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-15.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFWebView.h"
#import "WFAsyncHttp.h"
#import "WFWebUtil.h"


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

/*** http请求 ***/
@property (strong, nonatomic) WFAsyncHttpClient *httpClient;

@property (assign, nonatomic) WFAsyncCachePolicy cachePolicy;

@end


@implementation WFWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.urlStringStack = [WFWebViewURLStringStack new];
        self.httpClient = [[WFAsyncHttpClient alloc] init];
    }
    return self;
}

#pragma mark - start request
- (void)requestWihtURLString:(NSString *)URLString baseURL:(NSURL *)baseURL andCachePolicy:(WFAsyncCachePolicy)cachePolicy
{
    _currentRequestURLString = URLString;
    [self.urlStringStack pushWithKey:URLString];
    self.baseURL = baseURL;
    self.cachePolicy = cachePolicy;
    [self requestWihtURLString:URLString andCachePolicy:cachePolicy];
}

- (void)requestWihtURLString:(NSString *)URLString andCachePolicy:(WFAsyncCachePolicy)cachePolicy
{
    if(self.requestStartBlock)
    {
        self.requestStartBlock();
    }
    [self.httpClient setCachePolicy:cachePolicy];
    [self.httpClient GET_WithURLString:URLString andSuccess:^(id responseObject, BOOL cache)
     {
         [self loadHTMLString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] baseURL:self.baseURL];
     } andFailure:^(NSError *error) {
         if([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
         {
             [self.delegate webView:self didFailLoadWithError:error];
         }
     }];
}



- (void)reload
{
    if(self.currentRequestURLString == nil || [self.currentRequestURLString rangeOfString:@"http:"].length == 0) return;
    [self requestWihtURLString:self.currentRequestURLString andCachePolicy:self.cachePolicy];
}

- (BOOL)canGoBack
{
    return ![self.urlStringStack isEmpty];
}

- (void)goBack
{
    NSString *URLString = [self.urlStringStack pop];
    _currentRequestURLString = URLString;
    [self requestWihtURLString:URLString andCachePolicy:self.cachePolicy];
}

- (void)destoryAll
{
    [self.urlStringStack.dataArray removeAllObjects];
}

@end
