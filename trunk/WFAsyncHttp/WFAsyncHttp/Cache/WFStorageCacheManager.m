//
//  WFStorageCacheManager.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//
#define kWFAsynHttpCache_Folder    @"kWFAsynHttpCache_Folder" // *** 缓存文件包

#import "WFStorageCacheManager.h"
#import "WFFileManager.h"
#import "Base64.h"
#import "WFWebUtil.h"
#import "WFAsyncURLCache.h"

typedef enum : NSUInteger {
    WFAsynHttpCacheFolderType_Default,
    WFAsynHttpCacheFolderType_Image,
    WFAsynHttpCacheFolderType_Web,
} WFAsynHttpCacheFolderType;

@implementation WFStorageCacheManager
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
+ (float)getAllWebCacheSize
{
    NSString *folderPath = [self getFolderWithType:WFAsynHttpCacheFolderType_Web];
    return [WFFileManager getFileArraySizeWithType:WFFilePathTypeDocument andFolder:folderPath];
}
+ (float)getAllImageCacheSize
{
    NSString *folderPath = [self getFolderWithType:WFAsynHttpCacheFolderType_Image];
    return [WFFileManager getFileArraySizeWithType:WFFilePathTypeDocument andFolder:folderPath];
}
+ (float)getAllDefaultCacheSize
{
    NSString *folderPath = [self getFolderWithType:WFAsynHttpCacheFolderType_Default];
    return [WFFileManager getFileArraySizeWithType:WFFilePathTypeDocument andFolder:folderPath];
}

+ (BOOL)isExistWithKey:(NSString *)key
{
    if(key == nil || key.length == 0) return NO;
    return [WFFileManager isExistWithType:WFFilePathTypeDocument andFolder:[self getFolder:key] andKey:key];
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
        if([WFWebUtil isWebFileRequest:key])
        {
            return [self getFolderWithType:WFAsynHttpCacheFolderType_Web];
        }
        else if([WFWebUtil isImageRequest:key])
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
