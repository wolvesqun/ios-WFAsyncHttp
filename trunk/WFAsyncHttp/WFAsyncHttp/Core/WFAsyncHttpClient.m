//
//  WFAsyncHttpClient.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFAsyncHttpClient.h"
#import "WFAsyncHttpUtil.h"
#import "NSMutableURLRequest+WFAsyncHttpMutableURLRequest.h"
#import "WFAsynHttpCacheManager.h"


@implementation WFAsyncHttpClient

#pragma mark - 网络请求接口
+ (void)System_Request_WithURLString:(NSString *)URLString
                           andParams:(NSDictionary *)params
                          andHeaders:(NSDictionary *)headers
                       andHttpMethod:(NSString *)httpMethod
                      andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                          andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                          andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    // *** 传入参数无效
    if([WFAsyncHttpUtil handlerParamErrorWithURLString:URLString andSuccess:success andFailure:failure]) return;
    
    if([WFAsyncHttpUtil handleCacheWithKey:URLString andSuccess:success andCachePolicy:cachePolicy]) return;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:10];
    
    [request setHTTPMethod:httpMethod];
    [request addHttpHeaderWithRequest:[NSMutableDictionary dictionaryWithDictionary:headers]];
    [request addParamWithDict:params];
    
    // *** start
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [WFAsyncHttpUtil handleRequestResultWithKey:URLString
                                             andData:data
                                      andCachePolicy:cachePolicy
                                          andSuccess:success
                                            andError:connectionError
                                          andFailure:failure];
     }];
}

+ (void)System_Request_WithURLString:(NSString *)URLString
                           andParams:(NSDictionary *)params
                          andHeaders:(NSDictionary *)headers
                       andHttpMethod:(NSString *)httpMethod
                          andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                          andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:params andHeaders:headers andHttpMethod:httpMethod andCachePolicy:WFAsyncCachePolicyType_Default andSuccess:success andFailure:failure];
}

#pragma mark - GET请求
+ (void)System_GET_WithURLString:(NSString *)URLString
                      andHeaders:(NSDictionary *)headers
                  andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:nil andHeaders:headers andHttpMethod:kWFHttpRequestType_GET andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}

+ (void)System_GET_WithURLString:(NSString *)URLString
                  andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:nil andHeaders:nil andHttpMethod:kWFHttpRequestType_GET andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}


#pragma mark - POST请求
+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                       andHeaders:(NSDictionary *)headers
                   andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:params andHeaders:headers andHttpMethod:kWFHttpRequestType_POST andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}

+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                   andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:params andHeaders:nil andHttpMethod:kWFHttpRequestType_POST andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}


#pragma mark - 自定义
+ (void)requestWithRequest:(NSURLRequest *)request
            andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    NSString *URLString = request.URL.absoluteURL.absoluteString;
    // *** 传入参数无效
    if([WFAsyncHttpUtil handlerParamErrorWithURLString:URLString andSuccess:success andFailure:failure]) return;
    
    if([WFAsyncHttpUtil handleCacheWithKey:URLString andSuccess:success andCachePolicy:cachePolicy]) return;
    
    // *** start
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [WFAsyncHttpUtil handleRequestResultWithKey:URLString andData:data andCachePolicy:cachePolicy andSuccess:success andError:connectionError andFailure:failure];
     }];
}


@end
