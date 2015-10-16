//
//  WFAsyncHttpUtil.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//
//  Github : https://github.com/wolvesqun/IOS-WFAsyncHttp
//  当前版本 2.0.1



#import <UIKit/UIKit.h>
#import "WFAsyncHttpCONST.h"

@interface WFAsyncHttpUtil : NSObject

+ (BOOL)handlerParamErrorWithURLString:(NSString *)URLString
                            andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                            andFailure:(WFFailureAsyncHttpDataCompletion)failure;


+ (NSData *)getURLParamWithDict:(NSDictionary *)dict;

+ (NSDictionary *)getUserAgentWithValue:(NSString *)value;

/**
 *  获取默认user-agent
 */
+ (NSString *)getDefaultUserAgent;

#pragma mark - 处理请求结果
+ (void)handleRequestResultWithKey:(NSString *)key
                           andData:(NSData *)data
                    andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                        andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                          andError:(NSError *)error
                        andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)handleRequestResultWithKey:(NSString *)key
                           andData:(NSData *)data
                    andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                        andSuccess:(WFSuccessAsyncHttpDataCompletion)success;

+ (void)handleRequestResultWithError:(NSError *)error
                          andFailure:(WFFailureAsyncHttpDataCompletion)failure;

#pragma mark - 处理缓存
+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success andCachePolicy:(WFAsyncCachePolicy)cachePolicy;

+ (BOOL)isImageRequest:(NSString *)URLString;
+ (BOOL)isWebFileRequest:(NSString *) URLString;



@end
