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
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:10];
    
    switch (cachePolicy) {
        case WFAsyncCachePolicyType_ReturnCache_DidLoad:
        {
            [WFAsyncHttpUtil handleCacheWithKey:URLString andSuccess:success];
            break;
        }
        case WFAsyncCachePolicyType_ReturnCache_DontLoad:
        {
            if([WFAsyncHttpUtil handleCacheWithKey:URLString andSuccess:success])
            {
                return;
            }
            break;
        }
        case WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet:
        {
            
            break;
        }
            
        default:
            break;
    }
    
    [request setHTTPMethod:httpMethod];
    [request addHttpHeaderWithRequest:[NSMutableDictionary dictionaryWithDictionary:headers]];
    [request addParamWithDict:params];
    
    // *** start
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(connectionError == nil)
         {
             if(cachePolicy != WFAsyncCachePolicyType_Default)
             {
                 
                 [WFAsynHttpCacheManager saveWithData:data andKey:URLString];
             }
             [WFAsyncHttpUtil handleSuccessWithData:data andSuccess:success];
         }
         else
         {
             if(cachePolicy == WFAsyncCachePolicyType_ReturnCache_WhenNotConnectedInternet)
             {
                 
                 if([WFAsyncHttpUtil handleCacheWithKey:URLString andSuccess:success])
                 {
                     return;
                 }
             }
             [WFAsyncHttpUtil handleFailureWithError:connectionError andFailure:failure];
         }
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
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:nil andHeaders:headers andHttpMethod:kWFHttpRequestType_GET andSuccess:success andFailure:failure];
}

+ (void)System_GET_WithURLString:(NSString *)URLString
                      andHeaders:(NSDictionary *)headers
                  andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:nil andHeaders:headers andHttpMethod:kWFHttpRequestType_GET andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}

+ (void)System_GET_WithURLString:(NSString *)URLString
                    andUserAgent:(NSString *)userAgent
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    
    [self System_GET_WithURLString:URLString andHeaders:[WFAsyncHttpUtil getUserAgentWithValue:userAgent] andSuccess:success andFailure:failure];
}

+ (void)System_GET_WithURLString:(NSString *)URLString
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_GET_WithURLString:URLString andSuccess:success andFailure:failure];
}

#pragma mark - POST请求
+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:params andHeaders:nil andHttpMethod:kWFHttpRequestType_POST andSuccess:success andFailure:failure];
}

+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                       andHeaders:(NSDictionary *)headers
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:params andHeaders:headers andHttpMethod:kWFHttpRequestType_POST andSuccess:success andFailure:failure];
}

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
                     andUserAgent:(NSString *)userAgent
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_POST_WithURLString:URLString andParams:params andHeaders:[WFAsyncHttpUtil getUserAgentWithValue:userAgent] andSuccess:success andFailure:failure];
}

+ (void)System_POST_WithURLString:(NSString *)URLString
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_POST_WithURLString:URLString andParams:nil andSuccess:success andFailure:failure];
}


@end
