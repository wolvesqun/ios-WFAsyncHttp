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
/**
 *  GET请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param defaultCache 默认缓存
 *  @param headers      请求头
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (void)GET_WithURLString:(NSString *)URLString
          andDefaultCache:(id)defaultCache
               andHeaders:(NSDictionary *)headers
           andCachePolicy:(WFAsyncCachePolicy)cachePolicy
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)GET_WithURLString:(NSString *)URLString
               andHeaders:(NSDictionary *)headers
           andCachePolicy:(WFAsyncCachePolicy)cachePolicy
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)GET_WithURLString:(NSString *)URLString
           andCachePolicy:(WFAsyncCachePolicy)cachePolicy
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure;



#pragma mark - POST请求

/**
 *  POST请求系统自带网络请求 -》可以设缓存
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
            andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;


@end
