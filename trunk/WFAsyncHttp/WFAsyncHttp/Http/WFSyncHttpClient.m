//
//  WFSyncHttpClient.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFSyncHttpClient.h"
#import "WFAsyncHttpUtil.h"
#import "NSMutableURLRequest+WFAsyncHttpMutableURLRequest.h"

@implementation WFSyncHttpClient


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
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    [WFAsyncHttpUtil handleRequestResultWithKey:URLString
                                        andData:data
                                 andCachePolicy:cachePolicy
                                     andSuccess:success
                                       andError:error
                                     andFailure:failure];
}


#pragma mark - GET请求
+ (void)System_GET_WithURLString:(NSString *)URLString
                       andParams:(NSDictionary *)params
                      andHeaders:(NSDictionary *)headers
                  andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:params andHeaders:headers andHttpMethod:kWFHttpRequestType_GET andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}

+ (void)System_GET_WithURLString:(NSString *)URLString
                       andParams:(NSDictionary *)params
                  andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self System_Request_WithURLString:URLString andParams:params andHeaders:nil andHttpMethod:kWFHttpRequestType_GET andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
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

@end
