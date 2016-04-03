//
//  WFCachePolicyHelper.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "WFCachePolicyHelper.h"

@implementation WFCachePolicyHelper


#pragma mark -
// - 根据策略是否要返回缓存
+ (BOOL)canReturnStoryageCacheWithCachePolicy:(WFStoreCachePolicy)cachePolicy
{
    if(cachePolicy == WFStoreCachePolicyType_Default || cachePolicy == WFStoreCachePolicyType_Reload_IgnoringLocalCache)
    {
        return NO;
    }
    return YES;
}
+ (BOOL)canReturnMemcacheCacheWithCachePolicy:(WFMemCachePolicy)cachePolicy
{
    if(cachePolicy == WFMemCachePolicyType_ReturnCache_ElseLoad)
    {
        return YES;
    }
    return NO;
}

// - 根据策略是否要继续请求
+ (BOOL)canLoadWithStoreCachePolicy:(WFStoreCachePolicy)cachePolicy
{
    if(cachePolicy == WFStoreCachePolicyType_ReturnCache_DidLoad ||
       cachePolicy == WFStoreCachePolicyType_ReturnCacheOrNil_DidLoad ||
       cachePolicy == WFStoreCachePolicyType_Reload_IgnoringLocalCache )
    {
        return YES;
    }
    return NO;
}

+ (BOOL)canLoadWithMemCachePolicy:(WFMemCachePolicy)cachePolicy
{
    if(cachePolicy == WFMemCachePolicyType_ReturnCache_ElseLoad)
    {
        return NO;
    }
    return YES;
}


@end
