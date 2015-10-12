//
//  WFAsynHttpCacheManager.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-12.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#define kWFAsynHttpCache_Folder @"kWFAsynHttpCache_Folder"

#import "WFAsynHttpCacheManager.h"
#import "WFFileManager.h"
#import "Base64.h"

@implementation WFAsynHttpCacheManager

+ (void)saveWithData:(NSData *)data andKey:(NSString *)key
{
    if(data == nil || key == nil || key.length == 0) return;
    [WFFileManager saveWithType:WFFilePathTypeDocument andFolder:kWFAsynHttpCache_Folder andData:[Base64 encodeData:data] andKey:key];
}

+ (NSData *)getWithKey:(NSString *)key
{
    return [Base64 decodeData:[WFFileManager getWithType:WFFilePathTypeDocument andFolder:kWFAsynHttpCache_Folder andKey:key]];
}

+ (void)removeAllCache
{
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:kWFAsynHttpCache_Folder];
}

+ (void)removeWithKey:(NSString *)key
{
    if(key == nil || key.length == 0) return;
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:kWFAsynHttpCache_Folder andKey:key];
}

+ (BOOL)isExistWithKey:(NSString *)key
{
    if(key == nil || key.length == 0) return NO;
    return [WFFileManager isExistWityType:WFFilePathTypeDocument andFolder:kWFAsynHttpCache_Folder andKey:key];
}

@end
