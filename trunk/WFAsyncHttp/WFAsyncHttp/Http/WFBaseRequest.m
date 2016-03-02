//
//  WFBaseRequest.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/1.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "WFBaseRequest.h"
#import "WFAsyncHttpCacheManager.h"

@implementation WFBaseRequest

#pragma mark - 请求结果处理
// - request success
+ (void)handleRequestResultWithKey:(NSString *)key
                           andData:(NSData *)data
                    andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                        andSuccess:(WFSuccessAsyncHttpDataCompletion)success
{
    // *** save data
    if(cachePolicy != WFAsyncCachePolicyType_Default && data)
    {
        [WFAsyncHttpCacheManager saveWithData:data andKey:key];
    }
    [self handleDataSuccess:data andSuccess:success andCache:NO];
}
// - request error
+ (void)handleRequestResultWithError:(NSError *)error
                          andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    if(failure) failure(error);
}


+ (void)handleDataSuccess:(NSData *)data andSuccess:(WFSuccessAsyncHttpDataCompletion)success andCache:(BOOL)cache
{
    if(success)
    {
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error == nil)
        {
            success(jsonObject, cache);
        }
        else
        {
            success(data, cache);
        }
    }
}

+ (void)handleDataFailure:(NSError *)error andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    if(failure) failure(error);
}


+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success
{
    BOOL b = [WFAsyncHttpCacheManager isExistWithKey:key];
    if(b && key && key.length > 0)
    {
        NSData *cacheData = [WFAsyncHttpCacheManager getWithKey:key];
        [self handleDataSuccess:cacheData andSuccess:success andCache:YES];
    }
    return b;
}

+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success andCachePolicy:(WFAsyncCachePolicy)cachePolicy
{
    return [self handleCacheWithKey:key andSuccess:success andCachePolicy:cachePolicy andDefaultCache:nil];
}

+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success andCachePolicy:(WFAsyncCachePolicy)cachePolicy andDefaultCache:(id)defaultCache
{
    switch (cachePolicy) {
        case WFAsyncCachePolicyType_ReturnCache_DidLoad:
        {
            BOOL isFinish = [self handleCacheWithKey:key andSuccess:success];
            if(!isFinish && defaultCache)
            {
                if(success) success(defaultCache, YES);
            }
            break;
        }
        case WFAsyncCachePolicyType_ReturnCache_DontLoad:
        {
            [self handleCacheWithKey:key andSuccess:success];
            return YES;
        }
        case WFAsyncCachePolicyType_ReturnCache_ElseLoad:
        {
            if([self handleCacheWithKey:key andSuccess:success])
            {
                return YES;
            }
            else
            {
                if(defaultCache)
                {
                    if(success){
                        success(defaultCache, YES);
                        return YES;
                    }
                    
                }
            }
            
            
            break;
        }
        case WFAsyncCachePolicyType_Reload_IgnoringLocalCache:
        {
            
            break;
        }
            
            
        default:
            break;
    }
    return NO;
}

@end
