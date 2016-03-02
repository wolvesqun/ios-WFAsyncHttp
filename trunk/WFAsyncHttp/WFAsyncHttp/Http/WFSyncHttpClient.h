//
//  WFSyncHttpClient.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAsyncHttpCONST.h"
#import "WFBaseRequest.h"

/**
 *  同步请求
 */
@interface WFSyncHttpClient : WFBaseRequest

#pragma mark - GET请求
+ (void)System_GET_WithURLString:(NSString *)URLString
                       andParams:(NSDictionary *)params
                      andHeaders:(NSDictionary *)headers
                  andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)System_GET_WithURLString:(NSString *)URLString
                       andParams:(NSDictionary *)params
                  andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                      andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                      andFailure:(WFFailureAsyncHttpDataCompletion)failure;


#pragma mark - POST请求
+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                       andHeaders:(NSDictionary *)headers
                   andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure;

+ (void)System_POST_WithURLString:(NSString *)URLString
                        andParams:(NSDictionary *)params
                   andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                       andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                       andFailure:(WFFailureAsyncHttpDataCompletion)failure;

@end
