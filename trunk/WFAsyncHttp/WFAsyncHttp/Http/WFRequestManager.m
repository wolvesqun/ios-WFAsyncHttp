//
//  WFRequestManager.m
//  WFAsyncHttp
//
//  Created by mba on 15/3/1.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "WFRequestManager.h"
#import "WFStorageCacheManager.h"
#import "WFBaseRequest.h"
#import "WFMemcacheManager.h"

@implementation WFRequestManager



@end


#pragma mark - ************************ 使用本地缓存 ************************
@implementation WFRequestManager(WFExtensionRequestUsingStorageCache)

#pragma mark - 请求接口
/**
 *  GET请求系统自带网络请求 -》带缓存
 *
 *  @param URLString    请求地址
 *  @param headers      请求头
 *  @param cachePolicy  缓存策略
 *  @param success      成功回调
 *  @param failure      错误回调
 */
+ (void)GET_UsingStorageCache_WithURLString:(NSString *)URLString
                                  andHeader:(NSDictionary *)header
                               andUserAgent:(NSString *)userAgent
                             andCachePolicy:(WFStorageCachePolicy)cachePolicy
                                 andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                                 andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    BOOL b = [WFStorageCacheManager isExistWithKey:URLString];
    if(b && [WFCachePolicyHelper canReturnStoryageCacheWithCachePolicy:cachePolicy])
    {
        NSData *cacheData = [WFStorageCacheManager getWithKey:URLString];
        [self Storage_finishRequestWithData:cacheData andResponse:nil andSuccess:success andCache:YES];
        
        if(![WFCachePolicyHelper canLoadWithStorageCachePolicy:cachePolicy]) return;
    }
    
    [WFBaseRequest requestDataWithURLString:URLString
                                  andParams:nil
                                  andHeader:header
                               andUserAgent:userAgent
                              andHttpMethod:kWFHttpRequestType_GET
                                 andSuccess:^(NSData *data, NSURLResponse *response)
     {
         if(data != nil)
         {
             [self Storage_handlerRequestFinishWithKey:URLString andData:data andResponse:response andStorageCachePolicy:cachePolicy andSuccess:success];
         }
         else
         {
             [self Storage_handlerRequestFinishWithError:nil andFailure:failure];
         }
     } andFailure:failure];
}

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
+ (void)POST_UsingStorageCache_WithURLString:(NSString *)URLString
                                   andHeader:(NSDictionary *)header
                                andUserAgent:(NSString *)userAgent
                                    andParam:(NSDictionary *)param
                              andCachePolicy:(WFStorageCachePolicy)cachePolicy
                                  andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                                  andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    BOOL b = [WFStorageCacheManager isExistWithKey:URLString];
    if(b && [WFCachePolicyHelper canReturnStoryageCacheWithCachePolicy:cachePolicy])
    {
        NSData *cacheData = [WFStorageCacheManager getWithKey:URLString];
        [self Storage_finishRequestWithData:cacheData andResponse:nil andSuccess:success andCache:YES];
        
        if(![WFCachePolicyHelper canLoadWithStorageCachePolicy:cachePolicy]) return;
    }
    
    [WFBaseRequest requestDataWithURLString:URLString
                                  andParams:param
                                  andHeader:header
                               andUserAgent:userAgent
                              andHttpMethod:kWFHttpRequestType_POST
                                 andSuccess:^(NSData *data, NSURLResponse *response)
     {
         if(data != nil)
         {
             [self Storage_handlerRequestFinishWithKey:URLString andData:data andResponse:response andStorageCachePolicy:cachePolicy andSuccess:success];
         }
         else
         {
             [self Storage_handlerRequestFinishWithError:nil andFailure:failure];
         }
     } andFailure:failure];
}

#pragma mark -
// - 请求结果处理
+ (void)Storage_handlerRequestFinishWithKey:(NSString *)key
                                    andData:(NSData *)data
                                andResponse:(NSURLResponse *)response
                      andStorageCachePolicy:(WFStorageCachePolicy)cachePolicy
                                 andSuccess:(BLock_WFRequestDataSuccessCompletion)success
{
    if(cachePolicy != WFStorageCachePolicyType_Default && data)
    {
        [WFStorageCacheManager saveWithData:data andKey:key];
    }
    [self Storage_finishRequestWithData:data andResponse:response andSuccess:success andCache:NO];
}



+ (void)Storage_handlerRequestFinishWithError:(NSError *)error
                                   andFailure:(BLock_WFRequestDataFailureCompletion)failure;
{
    if(error == nil)
    {
        static NSError *tempError = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if(tempError == nil)
            {
                tempError = [NSError errorWithDomain:@"WFErrorServer" code:-1 userInfo:@{@"kWFErrorServer":@"服务端异常"}];
            }
        });
        error = tempError;
    }
    if(failure) failure(error);
}


// - 结束请求并返回json数据（如果是json数据）
+ (void)Storage_finishRequestWithData:(NSData *)data
                          andResponse:(NSURLResponse *)response
                           andSuccess:(BLock_WFRequestDataSuccessCompletion)success andCache:(BOOL)isCache
{
    if(success)
    {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if(jsonObject != nil)
        {
            success(jsonObject, response, isCache);
        }
        else
        {
            success(data, nil, isCache);
        }
    }
}


@end

#pragma mark - ************************ 使用内存缓存与本地缓存 ************************
@implementation WFRequestManager(WFExtensionRequestUsingMemCache)


#pragma mark - 请求接口
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
+ (void)GET_UsingMemCache_WithURLString:(NSString *)URLString
                              andHeader:(NSDictionary *)header
                           andUserAgent:(NSString *)userAgent
                       andStoragePolicy:(WFStorageCachePolicy)storagePolicy
                          andExpireTime:(NSTimeInterval)expireTime
                      andMemCachePolicy:(WFMemCachePolicy)memcachePolicy
                             andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                             andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    id cacheData = [WFMemcacheManager getCacheWithKey:URLString];
    if(cacheData && [WFCachePolicyHelper canReturnMemcacheCacheWithCachePolicy:memcachePolicy])
    {
        [self Memory_getFinishedHandlerDataWithData:cacheData andResponse:nil andSuccess:success andCache:YES];
        if(![WFCachePolicyHelper canLoadWithMemCachePolicy:memcachePolicy]) return;
    }
    
    [self GET_UsingStorageCache_WithURLString:URLString
                                    andHeader:header
                                 andUserAgent:userAgent
                               andCachePolicy:storagePolicy
                                   andSuccess:^(id responseDate, NSURLResponse *response, BOOL isCache)
     {
         [self Memory_handlerRequestFinishWithKey:URLString
                                          andData:responseDate
                                      andResponse:response
                                         andCache:isCache
                                    andExpireTime:expireTime
                                andMemCachePolicy:memcachePolicy
                                       andSuccess:success];
     } andFailure:failure];
}

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
+ (void)POST_UsingMemCache_WithURLString:(NSString *)URLString
                               andHeader:(NSDictionary *)header
                            andUserAgent:(NSString *)userAgent
                                andParam:(NSDictionary *)param
                        andStoragePolicy:(WFStorageCachePolicy)storagePolicy
                           andExpireTime:(NSTimeInterval)expireTime
                          andCachePolicy:(WFMemCachePolicy)cachePolicy
                              andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                              andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    id cacheData = [WFMemcacheManager getCacheWithKey:URLString];
    if(cacheData && [WFCachePolicyHelper canReturnMemcacheCacheWithCachePolicy:cachePolicy])
    {
        [self Memory_getFinishedHandlerDataWithData:cacheData andResponse:nil andSuccess:success andCache:YES];
        if(![WFCachePolicyHelper canLoadWithMemCachePolicy:cachePolicy]) return;
    }
    
   
    [self POST_UsingStorageCache_WithURLString:URLString
                                     andHeader:header
                                  andUserAgent:userAgent
                                      andParam:param
                                andCachePolicy:storagePolicy
                                    andSuccess:^(id responseDate, NSURLResponse *response, BOOL isCache)
     {
         [self Memory_handlerRequestFinishWithKey:URLString
                                          andData:responseDate
                                      andResponse:response
                                         andCache:isCache
                                    andExpireTime:expireTime
                                andMemCachePolicy:cachePolicy
                                       andSuccess:success];
     } andFailure:failure];
}


+ (void)Memory_handlerRequestFinishWithKey:(NSString *)key
                                   andData:(id)data
                               andResponse:(NSURLResponse *)response
                                  andCache:(BOOL)isCache
                             andExpireTime:(NSTimeInterval)expireTime
                         andMemCachePolicy:(WFMemCachePolicy)cachePolicy
                                andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
{
    
    
    id myData = [self Memory_getFinishedHandlerDataWithData:data andResponse:response andSuccess:success andCache:isCache];
    
    if(cachePolicy != WFMemCachePolicyType_Default && data)
    {
        [WFMemcacheManager addWithData:myData andKey:key andExpiredTime:expireTime];
    }
    
}

+ (id)Memory_getFinishedHandlerDataWithData:(id)data
                                andResponse:(NSURLResponse *)response
                                 andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                                   andCache:(BOOL)isCache
{
    return success(data, response, isCache);
}


@end
