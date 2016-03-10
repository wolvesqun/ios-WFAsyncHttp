//
//  WFCachePolicyHelper.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,WFStorageCachePolicy)
{
    WFStorageCachePolicyType_Default,                     // *** 不提供缓存
    WFStorageCachePolicyType_ReturnCache_ElseLoad,        // *** 如果有缓存则返回缓存不加载网络，否则加载网络数据并且缓存数据
    WFStorageCachePolicyType_ReturnCache_DontLoad,        // *** 如果有缓存则返回缓存并且不加载网络
    WFStorageCachePolicyType_ReturnCache_DidLoad,         // *** 如果有缓存则返回缓存并且都加载网络
    WFStorageCachePolicyType_ReturnCacheOrNil_DidLoad,    // *** 如果有缓存则返回缓存,没有缓存就返回空的,并且都加载网络
    WFStorageCachePolicyType_Reload_IgnoringLocalCache,   // *** 忽略本地缓存并加载 （使用在更新缓存）
};

#pragma mark - 内存缓存策略
typedef NS_ENUM(NSUInteger,WFMemCachePolicy)
{
    WFMemCachePolicyType_Default,                     // *** 不提供缓存
    WFMemCachePolicyType_ReturnCache_ElseLoad,        // *** 如果内存有缓存缓存不加载网络，否则加载网络数据并且缓存数据
    WFMemCachePolicyType_Reload_IgnoringLocalCache,   // *** 忽略内存缓存并加载 （使用在更新缓存）
};



@interface WFCachePolicyHelper : NSObject



#pragma mark -
// - 根据策略是否要返回缓存
+ (BOOL)canReturnStoryageCacheWithCachePolicy:(WFStorageCachePolicy)cachePolicy;
+ (BOOL)canReturnMemcacheCacheWithCachePolicy:(WFMemCachePolicy)cachePolicy;

// - 根据策略是否要继续请求
+ (BOOL)canLoadWithStorageCachePolicy:(WFStorageCachePolicy)cachePolicy;

+ (BOOL)canLoadWithMemCachePolicy:(WFMemCachePolicy)cachePolicy;


@end
