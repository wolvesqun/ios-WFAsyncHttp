//
//  WFSyncHttpClient.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAsyncHttpCONST.h"

/**
 *  同步请求
 */
@interface WFSyncHttpClient : NSObject

#pragma mark - GET请求
+ (void)System_GET_WithURLString:(NSString *)URLString
                      andHeaders:(NSDictionary *)headers
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)System_GET_WithURLString:(NSString *)URLString
                    andUserAgent:(NSString *)userAgent
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure;


+ (void)System_GET_WithURLString:(NSString *)URLString
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure;

#pragma mark - POST请求
+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                       andHeaders:(NSDictionary *)headers
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                     andUserAgent:(NSString *)userAgent
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)System_POST_WithURLString:(NSString *)URLString
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure;

@end
