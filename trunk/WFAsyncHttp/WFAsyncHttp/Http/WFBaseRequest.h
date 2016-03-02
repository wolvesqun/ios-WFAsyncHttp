//
//  WFBaseRequest.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/1.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAsyncHttpCONST.h"

@interface WFBaseRequest : NSObject

#pragma mark - 处理请求结果
+ (void)handleRequestResultWithKey:(NSString *)key
                           andData:(NSData *)data
                    andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                        andSuccess:(WFSuccessAsyncHttpDataCompletion)success;

+ (void)handleRequestResultWithError:(NSError *)error
                          andFailure:(WFFailureAsyncHttpDataCompletion)failure;

#pragma mark - 处理缓存
+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success andCachePolicy:(WFAsyncCachePolicy)cachePolicy;
+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success andCachePolicy:(WFAsyncCachePolicy)cachePolicy andDefaultCache:(id)defaultCache;
@end
