//
//  WFCachePolicyHelper.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "WFCachePolicyHelper.h"

@implementation WFCachePolicyHelper

+ (WFStorageCachePolicy)getStoryPolicyWithMemCachePolicy:(WFMemCachePolicy)cachePolicy
{
    switch (cachePolicy) {
        case WFMemCachePolicyType_Default:
        {
            return WFStorageCachePolicyType_Default;
        }
        case WFMemCachePolicyType_ReturnCache_ElseLoad:
        {
            return WFStorageCachePolicyType_ReturnCache_ElseLoad;
        }
        case WFMemCachePolicyType_ReturnCache_DidLoad:
        {
            return WFStorageCachePolicyType_ReturnCache_DidLoad;
        }
        case WFMemCachePolicyType_ReturnCache_DontLoad:
        {
            return WFStorageCachePolicyType_ReturnCache_DontLoad;
        }
        case WFMemCachePolicyType_ReturnCacheOrNil_DidLoad:
        {
            return WFStorageCachePolicyType_ReturnCacheOrNil_DidLoad;
        }
        case WFMemCachePolicyType_Reload_IgnoringLocalCache:
        {
            return WFStorageCachePolicyType_Reload_IgnoringLocalCache;
        }
            
        default:
            break;
    }
    return WFStorageCachePolicyType_Default;
}

#pragma mark -
// - 根据策略是否要返回缓存
+ (BOOL)canReturnStoryageCacheWithCachePolicy:(WFStorageCachePolicy)cachePolicy
{
    if(cachePolicy == WFStorageCachePolicyType_Default ||
       cachePolicy == WFStorageCachePolicyType_ReturnCacheOrNil_DidLoad )
    {
        return NO;
    }
    return YES;
}
+ (BOOL)canReturnMemcacheCacheWithCachePolicy:(WFMemCachePolicy)cachePolicy
{
    if(cachePolicy == WFMemCachePolicyType_Default ||
       cachePolicy == WFMemCachePolicyType_ReturnCacheOrNil_DidLoad )
    {
        return NO;
    }
    return YES;
}

// - 根据策略是否要继续请求
+ (BOOL)canLoadWithStorageCachePolicy:(WFStorageCachePolicy)cachePolicy
{
    if(cachePolicy == WFStorageCachePolicyType_ReturnCache_DidLoad ||
       cachePolicy == WFStorageCachePolicyType_ReturnCacheOrNil_DidLoad ||
       cachePolicy == WFStorageCachePolicyType_Reload_IgnoringLocalCache )
    {
        return YES;
    }
    return NO;
}

+ (BOOL)canLoadWithMemCachePolicy:(WFMemCachePolicy)cachePolicy
{
    if(cachePolicy == WFStorageCachePolicyType_ReturnCache_DidLoad ||
       cachePolicy == WFStorageCachePolicyType_ReturnCacheOrNil_DidLoad ||
       cachePolicy == WFStorageCachePolicyType_Reload_IgnoringLocalCache )
    {
        return YES;
    }
    return NO;
}


@end
