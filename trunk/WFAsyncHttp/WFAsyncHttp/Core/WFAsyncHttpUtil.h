//
//  WFAsyncHttpUtil.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

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

+ (void)handleSuccessWithData:(NSData *)data andSuccess:(WFSuccessAsyncHttpDataCompletion)success;
+ (void)handleFailureWithError:(NSError *)error andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success;

+ (BOOL)isImageRequest:(NSString *)URLString;

@end
