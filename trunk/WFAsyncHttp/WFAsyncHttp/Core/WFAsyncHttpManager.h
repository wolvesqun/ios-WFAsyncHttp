//
//  WFAsyncHttpManager.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAsyncHttpCONST.h"
#import "WFAsyncHttpClient.h"

@interface WFAsyncHttpManager : NSObject

#pragma mark - GET请求
+ (void)GET_WithURLString:(NSString *)URLString
               andHeaders:(NSDictionary *)headers
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure;

/**
 *  GET请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param headers      请求头
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (void)GET_WithURLString:(NSString *)URLString
               andHeaders:(NSDictionary *)headers
           andCachePolicy:(WFAsyncCachePolicy)cachePolicy
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)GET_WithURLString:(NSString *)URLString
             andUserAgent:(NSString *)userAgent
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)GET_WithURLString:(NSString *)URLString
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure;

#pragma mark - POST请求
+ (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
                andHeaders:(NSDictionary *)headers
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;

/**
 *  POST请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param Params       请求参数
 *  @param headers      请求头
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
                andHeaders:(NSDictionary *)headers
            andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
              andUserAgent:(NSString *)userAgent
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)POST_WithURLString:(NSString *)URLString
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;

@end
