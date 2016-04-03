//
//  WFRequestManager.m
//  WFAsyncHttp
//
//  Created by mba on 15/3/1.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "WFRequestManager.h"
#import "WFStoreCacheManager.h"
#import "WFBaseRequest.h"
#import "WFMemcacheManager.h"

@implementation WFRequestManager



@end


#pragma mark - ************************ 使用本地缓存 ************************
@implementation WFRequestManager(WFExtensionRequestUsingStoreCache)

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
+ (NSURLSessionDataTask *)GET_UsingStoreCache_WithURLString:(NSString *)URLString
                                  andHeader:(NSDictionary *)header
                               andUserAgent:(NSString *)userAgent
                             andCachePolicy:(WFStoreCachePolicy)cachePolicy
                                 andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                                 andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    BOOL b = [WFStoreCacheManager isExistWithKey:URLString];
    if(b && [WFCachePolicyHelper canReturnStoryageCacheWithCachePolicy:cachePolicy])
    {
        NSData *cacheData = [WFStoreCacheManager getWithKey:URLString];
        [self Store_finishRequestWithData:cacheData andResponse:nil andSuccess:success andFromType:WFDataFromType_LocalCache];
        
        if(![WFCachePolicyHelper canLoadWithStoreCachePolicy:cachePolicy]) return nil;
    }
    
    return [WFBaseRequest requestDataWithURLString:URLString
                                  andParams:nil
                                  andHeader:header
                               andUserAgent:userAgent
                              andHttpMethod:kWFHttpRequestType_GET
                                 andSuccess:^(NSData *data, NSURLResponse *response)
     {
         if(data != nil)
         {
             [self Store_handlerRequestFinishWithKey:URLString andData:data andResponse:response andStoreCachePolicy:cachePolicy andSuccess:success];
         }
         else
         {
             [self Store_handlerRequestFinishWithError:nil andFailure:failure];
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
+ (NSURLSessionDataTask *)POST_UsingStoreCache_WithURLString:(NSString *)URLString
                                   andHeader:(NSDictionary *)header
                                andUserAgent:(NSString *)userAgent
                                    andParam:(NSDictionary *)param
                              andCachePolicy:(WFStoreCachePolicy)cachePolicy
                                  andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                                  andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    BOOL b = [WFStoreCacheManager isExistWithKey:URLString];
    if(b && [WFCachePolicyHelper canReturnStoryageCacheWithCachePolicy:cachePolicy])
    {
        NSData *cacheData = [WFStoreCacheManager getWithKey:URLString];
        [self Store_finishRequestWithData:cacheData andResponse:nil andSuccess:success andFromType:WFDataFromType_LocalCache];
        
        if(![WFCachePolicyHelper canLoadWithStoreCachePolicy:cachePolicy]) return nil;
    }
    else if (cachePolicy == WFStoreCachePolicyType_ReturnCacheOrNil_DidLoad)
    {
        if(success) success(nil, nil, WFDataFromType_Default);
    }
    
    return [WFBaseRequest requestDataWithURLString:URLString
                                  andParams:param
                                  andHeader:header
                               andUserAgent:userAgent
                              andHttpMethod:kWFHttpRequestType_POST
                                 andSuccess:^(NSData *data, NSURLResponse *response)
     {
         if(data != nil)
         {
             [self Store_handlerRequestFinishWithKey:URLString andData:data andResponse:response andStoreCachePolicy:cachePolicy andSuccess:success];
         }
         else
         {
             [self Store_handlerRequestFinishWithError:nil andFailure:failure];
         }
     } andFailure:failure];
}

#pragma mark -
// - 请求结果处理
+ (void)Store_handlerRequestFinishWithKey:(NSString *)key
                                    andData:(NSData *)data
                                andResponse:(NSURLResponse *)response
                      andStoreCachePolicy:(WFStoreCachePolicy)cachePolicy
                                 andSuccess:(BLock_WFRequestDataSuccessCompletion)success
{
    if(cachePolicy != WFStoreCachePolicyType_Default && data)
    {
        [WFStoreCacheManager saveWithData:data andKey:key];
    }
    [self Store_finishRequestWithData:data andResponse:response andSuccess:success andFromType:WFDataFromType_Net];
}



+ (void)Store_handlerRequestFinishWithError:(NSError *)error
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
+ (void)Store_finishRequestWithData:(NSData *)data
                          andResponse:(NSURLResponse *)response
                           andSuccess:(BLock_WFRequestDataSuccessCompletion)success andFromType:(WFDataFromType)fromType
{
    if(success)
    {
        if(data)
        {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if(jsonObject != nil)
            {
                success(jsonObject, response, fromType);
                return;
            }
        }
        success(data, nil, fromType);
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
+ (NSURLSessionDataTask *)GET_UsingMemCache_WithURLString:(NSString *)URLString
                              andHeader:(NSDictionary *)header
                           andUserAgent:(NSString *)userAgent
                       andStorePolicy:(WFStoreCachePolicy)StorePolicy
                          andExpireTime:(NSTimeInterval)expireTime
                      andMemCachePolicy:(WFMemCachePolicy)memcachePolicy
                             andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                             andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    id cacheData = [WFMemcacheManager getCacheWithKey:URLString];
    if(cacheData && [WFCachePolicyHelper canReturnMemcacheCacheWithCachePolicy:memcachePolicy])
    {
        [self Memory_getFinishedHandlerDataWithData:cacheData andResponse:nil andSuccess:success andFromType:WFDataFromType_Memcache];
        if(![WFCachePolicyHelper canLoadWithMemCachePolicy:memcachePolicy]) return nil;
    }
    
    return [self GET_UsingStoreCache_WithURLString:URLString
                                    andHeader:header
                                 andUserAgent:userAgent
                               andCachePolicy:StorePolicy
                                   andSuccess:^(id responseDate, NSURLResponse *response, WFDataFromType fromType)
     {
         [self Memory_handlerRequestFinishWithKey:URLString
                                          andData:responseDate
                                      andFromType:fromType
                                      andResponse:response
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
+ (NSURLSessionDataTask *)POST_UsingMemCache_WithURLString:(NSString *)URLString
                               andHeader:(NSDictionary *)header
                            andUserAgent:(NSString *)userAgent
                                andParam:(NSDictionary *)param
                        andStorePolicy:(WFStoreCachePolicy)StorePolicy
                           andExpireTime:(NSTimeInterval)expireTime
                          andCachePolicy:(WFMemCachePolicy)cachePolicy
                              andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                              andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    id cacheData = [WFMemcacheManager getCacheWithKey:URLString];
    if(cacheData && [WFCachePolicyHelper canReturnMemcacheCacheWithCachePolicy:cachePolicy])
    {
        [self Memory_getFinishedHandlerDataWithData:cacheData andResponse:nil andSuccess:success andFromType:WFDataFromType_Memcache];
        if(![WFCachePolicyHelper canLoadWithMemCachePolicy:cachePolicy]) return nil;
    }
    
   
    return [self POST_UsingStoreCache_WithURLString:URLString
                                     andHeader:header
                                  andUserAgent:userAgent
                                      andParam:param
                                andCachePolicy:StorePolicy
                                    andSuccess:^(id responseDate, NSURLResponse *response, WFDataFromType fromType)
     {
         [self Memory_handlerRequestFinishWithKey:URLString
                                          andData:responseDate
                                      andFromType:fromType
                                      andResponse:response
                                    andExpireTime:expireTime
                                andMemCachePolicy:cachePolicy
                                       andSuccess:success];
     } andFailure:failure];
}


+ (void)Memory_handlerRequestFinishWithKey:(NSString *)key
                                   andData:(id)data
                               andFromType:(WFDataFromType)fromType
                               andResponse:(NSURLResponse *)response
                             andExpireTime:(NSTimeInterval)expireTime
                         andMemCachePolicy:(WFMemCachePolicy)cachePolicy
                                andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
{
    
    
    id myData = [self Memory_getFinishedHandlerDataWithData:data andResponse:response andSuccess:success andFromType:fromType];
    
    if(cachePolicy != WFMemCachePolicyType_Default && data)
    {
        [WFMemcacheManager addWithData:myData andKey:key andExpiredTime:expireTime];
    }
    
}

+ (id)Memory_getFinishedHandlerDataWithData:(id)data
                                andResponse:(NSURLResponse *)response
                                 andSuccess:(BLock_WFHandlerDataSuccessCompletion)success
                                andFromType:(WFDataFromType)fromType
{
    return success(data, response, fromType);
}


@end
