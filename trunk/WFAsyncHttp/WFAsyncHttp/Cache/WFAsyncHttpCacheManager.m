//
//  WFAsyncHttpCacheManager.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-16.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#define kWFAsynHttpCache_Folder             @"kWFAsynHttpCache_Folder" // *** 缓存文件包

#define kWFWFAsyncURLCacheData_Pre @"WFAsyncURLCacheData"



#import "WFAsyncHttpCacheManager.h"
#import "WFFileManager.h"
#import "Base64.h"
#import "WFAsyncHttpUtil.h"
#import "WFAsyncURLCache.h"

typedef enum : NSUInteger {
    WFAsynHttpCacheFolderType_Default,
    WFAsynHttpCacheFolderType_Image,
    WFAsynHttpCacheFolderType_Web,
} WFAsynHttpCacheFolderType;

@implementation WFAsyncHttpCacheManager
#pragma mark - 添加 | 获取 | 判断
+ (void)saveWithData:(id)data andKey:(NSString *)key
{
    if(data == nil || key == nil || key.length == 0) return;
    [WFFileManager saveWithType:WFFilePathTypeDocument andFolder:[self getFolder:key] andData:data andKey:key];
    
}

+ (NSData *)getWithKey:(NSString *)key
{
    id data = [WFFileManager getWithType:WFFilePathTypeDocument andFolder:[self getFolder:key] andKey:key];
    return data;
}
+ (BOOL)isExistWithKey:(NSString *)key
{
    if(key == nil || key.length == 0) return NO;
    return [WFFileManager isExistWityType:WFFilePathTypeDocument andFolder:[self getFolder:key] andKey:key];
}



#pragma mark - 清除缓存
+ (void)removeAllCache
{
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:kWFAsynHttpCache_Folder];
}

+ (void)removeAllImageCache
{
    [self removeCacheWithType:WFAsynHttpCacheFolderType_Image];
}

+ (void)removeAllWebCache
{
    [self removeCacheWithType:WFAsynHttpCacheFolderType_Web];
}

+ (void)removeCacheWithType:(WFAsynHttpCacheFolderType)type
{
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:[self getFolderWithType:type]];
}

+ (void)removeWithKey:(NSString *)key
{
    if(key == nil || key.length == 0) return;
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:[self getFolder:key] andKey:key];
}

#pragma mark - 文件夹相关
+ (NSString *)getFolder:(NSString *)key
{
    
    if(key)
    {
        if([WFAsyncHttpUtil isWebFileRequest:key])
        {
            return [self getFolderWithType:WFAsynHttpCacheFolderType_Web];
        }
        else if([WFAsyncHttpUtil isImageRequest:key])
        {
            return [self getFolderWithType:WFAsynHttpCacheFolderType_Image];
        }
    }
    
    return [self getFolderWithType:WFAsynHttpCacheFolderType_Default];
}

+ (NSString *)getFolderWithType:(WFAsynHttpCacheFolderType)type
{
    NSMutableString *folder = [NSMutableString stringWithString:kWFAsynHttpCache_Folder];
    [folder appendString:@"/"];
    switch (type) {
        case WFAsynHttpCacheFolderType_Image:
        {
            [folder appendString:@"Image"];
            return folder;
            
        }
        case WFAsynHttpCacheFolderType_Web: //
        {
            [folder appendString:@"Web"];
            return folder;
        }
            
        default:
        {
            [folder appendString:@"Default"];
            return folder;
        }
            
    }
}


@end
