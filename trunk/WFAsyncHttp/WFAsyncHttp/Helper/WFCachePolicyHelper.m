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
+ (BOOL)canReturnStoryageCacheWithCachePolicy:(WFStorageCachePolicy)cachePolicy
{
    if(cachePolicy == WFStorageCachePolicyType_Default)
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
    if(cachePolicy == WFMemCachePolicyType_ReturnCache_ElseLoad)
    {
        return NO;
    }
    return YES;
}


@end
