//
//  WFAsyncHttpRequest.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFAsyncHttpRequest.h"
#import "NSMutableURLRequest+WFAsyncHttpMutableURLRequest.h"
#import "WFAsyncHttpUtil.h"
#import "WFAsyncHttpCacheManager.h"

@interface WFAsyncHttpRequest ()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/*** 请求成功Block ***/
@property (strong, nonatomic) WFSuccessAsyncHttpDataCompletion success;
/*** 请求失败block ***/
@property (strong, nonatomic) WFFailureAsyncHttpDataCompletion failure;
@property (strong, nonatomic) WFPercentAsyncHttpDataCompletion percent;

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *tempDownloadData;
@property (assign, nonatomic) float totalLength;


@property (strong, nonatomic) NSMutableDictionary *httpHeaders;

@property (assign, nonatomic) float timeoutInterval;


/*** 缓存策略 ***/
@property (assign, nonatomic) WFAsyncCachePolicy cachePolicy;


@end

@implementation WFAsyncHttpRequest

#pragma mark - 网络请求接口
- (void)request_WithURLString:(NSString *)URLString
                    andParams:(NSDictionary *)params
               andRequestType:(NSString *)requestType
                   andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                   andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    // *** 传入参数无效
    if([WFAsyncHttpUtil handlerParamErrorWithURLString:URLString andSuccess:success andFailure:failure]) return;
    
    self.success = success;
    self.failure = failure;
    
    if([WFAsyncHttpUtil handleCacheWithKey:URLString andSuccess:success andCachePolicy:self.cachePolicy]) return;
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:self.timeoutInterval];
    
    // *** 设置请求参数
    [request setHTTPMethod:requestType];
    [request addHttpHeaderWithRequest:self.httpHeaders];
    [request addParamWithDict:params];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.connection start];
}

/**
 * get请求2
 */
- (void)GET_WithURLString:(NSString *)URLString
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self request_WithURLString:URLString andParams:nil andRequestType:kWFHttpRequestType_GET andSuccess:success andFailure:failure];
}

/**
 * post请求1
 */
- (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self request_WithURLString:URLString andParams:params andRequestType:kWFHttpRequestType_POST andSuccess:success andFailure:failure];
}

/**
 * post请求2
 */
- (void)POST_WithURLString:(NSString *)URLString
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self POST_WithURLString:URLString andParams:nil andSuccess:success andFailure:failure];
}

#pragma mark - 设置请求头
- (void)setTimeoutInterval:(float)timeoutInterval
{
    if(timeoutInterval <= 0)
    {
        timeoutInterval = 10;
    }
    _timeoutInterval = timeoutInterval;
}

- (void)addUserAgent:(NSString *)userAgent
{
    [self addHttpHeaderWihtDict:[WFAsyncHttpUtil getUserAgentWithValue:userAgent]];
}

- (void)addHttpHeaderWihtKey:(NSString *)key andValue:(NSString *)value
{
    if(key == nil || key.length == 0 || value == nil || value.length == 0) return;
    if(self.httpHeaders == nil)
    {
        self.httpHeaders = [NSMutableDictionary dictionary];
    }
    [self.httpHeaders setObject:value forKey:key];
}
- (void)addHttpHeaderWihtDict:(NSDictionary *)dict
{
    for (id key in dict.allKeys) {
        id value = [dict objectForKey:key];
        [self addHttpHeaderWihtKey:key andValue:value];
    }
}

/**
 *  设置缓存策略（默认不提供）
 */
- (void)setCachePolicy:(WFAsyncCachePolicy)cachePolicy
{
    _cachePolicy = cachePolicy;
}


#pragma mark - 取消请求
- (void)cancel
{
    [self.connection cancel];
    self.tempDownloadData = nil;
    self.totalLength = -1;
    self.connection = nil;
    self.cachePolicy = WFAsyncCachePolicyType_Default;
    [self.httpHeaders removeAllObjects];
}

#pragma mark - NSURLConnection Delegate
// - 加载开始
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.tempDownloadData = [[NSMutableData alloc] init];
    self.totalLength = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.tempDownloadData appendData:data];
    if(self.percent && self.totalLength > 0)
    {
        self.percent(self.tempDownloadData.length / self.totalLength);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [WFAsyncHttpUtil handleRequestResultWithKey:connection.originalRequest.URL.absoluteString
                                        andData:self.tempDownloadData
                                 andCachePolicy:self.cachePolicy
                                     andSuccess:self.success];
    [self cancel];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [WFAsyncHttpUtil handleRequestResultWithError:error andFailure:self.failure];
    [self cancel];
}




@end
