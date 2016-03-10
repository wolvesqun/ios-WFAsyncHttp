//
//  WFStorageCacheManager.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  将数据保存到沙盒里
 */
@interface WFStorageCacheManager : NSObject
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
@end
