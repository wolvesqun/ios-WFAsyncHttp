//
//  WFAsynHttpCacheManager.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-12.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFAsynHttpCacheManager : NSObject

/**
 *  save data with a key
 */
+ (void)saveWithData:(id)data andKey:(NSString *)key;

+ (id)getWithKey:(NSString *)key;

/**
 *  remove all cache
 */
+ (void)removeAllCache;

/**
 *  remove all image cache
 */
+ (void)removeAllImageCache;

/**
 *  remove all web cache (css,js ...)
 */
+ (void)removeAllWebCache;

/**
 *  remove cache with a key
 */
+ (void)removeWithKey:(NSString *)key;

/**
 *  Checking cache is exist
 */
+ (BOOL)isExistWithKey:(NSString *)key;

+ (BOOL)checkURLCache:(NSString *)Key;

+ (NSString *)buildURLCacheKey:(NSString *)URLString;

@end
