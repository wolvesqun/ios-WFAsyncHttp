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

#pragma mark *********************************  WFWebView  **************************************************
@interface WFWebView ()<UIWebViewDelegate>

@property (assign, nonatomic) WFMemCachePolicy mCachePolicy;
@property (assign, nonatomic) WFStorageCachePolicy sCachePolicy;

@end


@implementation WFWebView

#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _urlStringStack = [WFWebViewURLStringStack new];
    }
    return self;
}

#pragma mark - request
- (void)requestWihtURLString:(NSString *)URLString
                     baseURL:(NSURL *)baseURL
       andStorageCachePolicy:(WFStorageCachePolicy)sCachePolicy
           andMemCachePolicy:(WFMemCachePolicy)mCachePolicy
{
    _currentRequestURLString = URLString;
    [self.urlStringStack pushWithKey:URLString];
    _baseURL = baseURL;
    self.sCachePolicy = sCachePolicy;
    self.mCachePolicy = mCachePolicy;
    
    [self requestWihtURLString:URLString];
}

- (void)requestWihtURLString:(NSString *)URLString
{
   
    if(self.BLock_requestStart)
    {
        self.BLock_requestStart();
    }
    [WFRequestManager GET_UsingMemCache_WithURLString:URLString
                                            andHeader:nil
                                         andUserAgent:nil
                                     andStoragePolicy:self.sCachePolicy
                                        andExpireTime:self.expireTime
                                    andMemCachePolicy:self.mCachePolicy
                                           andSuccess:^id(id responseDate, NSURLResponse *response, WFDataFromType fromType)
    {
        NSString *htmlString = nil;
        if(fromType == WFDataFromType_Memcache)
        {
            htmlString = responseDate;
            
        }
        else
        {
            htmlString = [[NSString alloc] initWithData:responseDate encoding:NSUTF8StringEncoding];
        }
        [self loadHTMLString:htmlString
                     baseURL:self.baseURL];
        
        return htmlString;
    } andFailure:^(NSError *error)
     {
         if([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
         {
             [self.delegate webView:self didFailLoadWithError:error];
         }
    }];
    
}


#pragma mark -
- (void)reload
{
    if(self.currentRequestURLString == nil || [self.currentRequestURLString rangeOfString:@"http:"].length == 0) return;
    [self requestWihtURLString:self.currentRequestURLString];
}

- (BOOL)canGoBack
{
    return ![self.urlStringStack isEmpty];
}

- (void)goBack
{
    NSString *URLString = [self.urlStringStack pop];
    _currentRequestURLString = URLString;
    [self requestWihtURLString:URLString];
}

#pragma mark -
- (void)destoryAll
{
    [self.urlStringStack.dataArray removeAllObjects];
}
- (void)replacingURLStackWithURLString:(NSString *)URLString andIndex:(NSInteger)index
{
    if(self.urlStringStack.dataArray.count - 1 <= index)
    {
        [self.urlStringStack.dataArray replaceObjectAtIndex:index withObject:URLString];
    }
}

@end
