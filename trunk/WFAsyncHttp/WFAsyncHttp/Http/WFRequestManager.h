//
//  WFRequestManager.h
//  WFAsyncHttp
//
//  Created by mba on 15/3/1.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCachePolicyHelper.h"
#import "WFAsyncHttpCONST.h"

@interface WFRequestManager : NSObject


@end

#pragma mark - ************************ 使用本地缓存 ************************
@interface WFRequestManager(WFExtensionRequestUsingStoreCache)

/**
 *  GET请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param headers      请求头
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (NSURLSessionDataTask *)GET_UsingStoreCache_WithURLString:(NSString *)URLString
                                andHeader:(NSDictionary *)header
                             andUserAgent:(NSString *)userAgent
                           andCachePolicy:(WFStoreCachePolicy)cachePolicy
                               andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                               andFailure:(BLock_WFRequestDataFailureCompletion)failure;

/**
 *  POST请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param headers      请求头
 *  @param param        请求参数
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (NSURLSessionDataTask *)POST_UsingStoreCache_WithURLString:(NSString *)URLString
                                 andHeader:(NSDictionary *)header
                              andUserAgent:(NSString *)userAgent
                                  andParam:(NSDictionary *)param
                            andCachePolicy:(WFStoreCachePolicy)cachePolicy
                                andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                                andFailure:(BLock_WFRequestDataFailureCompletion)failure;

@end

#pragma mark - ************************ 使用内存缓存与本地缓存 ************************
/**
 *  使用这里的请求接口将进一步提高响应性能，有一点要开发请注意，可以降低网络请求，从而间接提高服务器的稳定性
 */
@interface WFRequestManager(WFExtensionRequestUsingMemCache)

/**
 *  GET请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param headers      请求头
 *  @param userAgent
 *  @param expireTime   缓存失效时间
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (NSURLSessionDataTask *)GET_UsingMemCache_WithURLString:(NSString *)URLString
                              andHeader:(NSDictionary *)header
                           andUserAgent:(NSString *)userAgent
                         andStorePolicy:(WFStoreCachePolicy)StorePolicy
                          andExpireTime:(NSTimeInterval)expireTime
                      andMemCachePolicy:(WFMemCachePolicy)memcachePolicy
                             andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                             andFailure:(BLock_WFRequestDataFailureCompletion)failure;

/**
 *  POST请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param headers      请求头
 *  @param param        请求参数
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (NSURLSessionDataTask *)POST_UsingMemCache_WithURLString:(NSString *)URLString
                               andHeader:(NSDictionary *)header
                            andUserAgent:(NSString *)userAgent
                                andParam:(NSDictionary *)param
                          andStorePolicy:(WFStoreCachePolicy)StorePolicy
                           andExpireTime:(NSTimeInterval)expireTime
                          andCachePolicy:(WFMemCachePolicy)cachePolicy
                              andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                              andFailure:(BLock_WFRequestDataFailureCompletion)failure;

@end

