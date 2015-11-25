//
//  WFAsyncHttpRequest.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAsyncHttpCONST.h"

@interface WFAsyncHttpRequest : NSObject

/**
 * get请求
 */
- (void)GET_WithURLString:(NSString *)URLString
              andSuccess:(WFSuccessAsyncHttpDataCompletion)success
              andFailure:(WFFailureAsyncHttpDataCompletion)failure;

/**
 * post请求
 */
- (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;

/**
 * post请求
 */
- (void)POST_WithURLString:(NSString *)URLString
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure;


- (void)setTimeoutInterval:(float)timeoutInterval;

/**
 *  添加userAgent
 */
- (void)addUserAgent:(NSString *)userAgent;

/**
 *  添加请求头信息
 */
- (void)addHttpHeaderWihtKey:(NSString *)key andValue:(NSString *)value;
- (void)addHttpHeaderWihtDict:(NSDictionary *)dict;

/**
 *  设置缓存策略（默认不提供）
 */
- (void)setCachePolicy:(WFAsyncCachePolicy)cachePolicy;

// - 设置默认缓存 （当第一次加载缓存时没有缓存时又想有缓存可以设置）
- (void)setDefaultCache:(id)defaultCache;

- (void)cancel;





@end
