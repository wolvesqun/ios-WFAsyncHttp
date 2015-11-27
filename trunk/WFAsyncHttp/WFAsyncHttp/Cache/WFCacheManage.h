//
//  WFCacheManage.h
//  Wiki
//
//  Created by mba on 15/11/27.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  缓存管理器
 */
@interface WFCacheManage : NSObject
// save
+ (void)saveCacheWithKey:(NSString *)key andData:(id)data;

// delete
+ (void)deleteCache:(NSString *)key;

// get
+ (id)getCacheWithKey:(NSString *)key;

+ (float)getCacheSizeWithKey:(NSString *)key;

// exist
+ (BOOL)isExistWithKey:(NSString *)key;



@end
