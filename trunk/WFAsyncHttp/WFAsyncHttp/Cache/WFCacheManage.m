//
//  WFCacheManage.m
//  Wiki
//
//  Created by mba on 15/11/27.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import "WFCacheManage.h"
#import "WFFileManager.h"

@implementation WFCacheManage
+ (NSString *)getBaseFolder
{
    return @"kWFWFCacheManaget_Config";
}

+ (void)saveCacheWithKey:(NSString *)key andData:(id)data
{
    
    [WFFileManager saveWithType:WFFilePathTypeDocument andFolder:[self getBaseFolder] andData:data andKey:key];
}

// delete
+ (void)deleteCache:(NSString *)key
{
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:[self getBaseFolder] andKey:key];
}

// get
+ (id)getCacheWithKey:(NSString *)key
{
    return [WFFileManager getWithType:WFFilePathTypeDocument andFolder:[self getBaseFolder] andKey:key];
}

+ (float)getCacheSizeWithKey:(NSString *)key
{
    return [WFFileManager getFileArraySizeWithType:WFFilePathTypeDocument andFolder:[self getBaseFolder]];
}

// exist
+ (BOOL)isExistWithKey:(NSString *)key
{
    return [WFFileManager isExistWityType:WFFilePathTypeDocument andFolder:[self getBaseFolder] andKey:key];
}
@end
