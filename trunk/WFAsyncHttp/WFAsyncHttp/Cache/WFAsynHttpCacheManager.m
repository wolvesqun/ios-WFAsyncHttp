//
//  WFAsynHttpCacheManager.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-12.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#define kWFAsynHttpCache_Folder         @"kWFAsynHttpCache_Folder"
#define kWFAsynHttpCache_Folder_Image   @"Image"
#define kWFAsynHttpCache_Folder_Other   @"Other"

typedef enum : NSUInteger {
    WFAsynHttpCacheFolderType_Image,
    WFAsynHttpCacheFolderType_Other,
} WFAsynHttpCacheFolderType;

#import "WFAsynHttpCacheManager.h"
#import "WFFileManager.h"
#import "Base64.h"
#import "WFAsyncHttpUtil.h"

@implementation WFAsynHttpCacheManager

+ (void)saveWithData:(NSData *)data andKey:(NSString *)key
{
    if(data == nil || key == nil || key.length == 0) return;
    [WFFileManager saveWithType:WFFilePathTypeDocument andFolder:[self getFolder:key] andData:[Base64 encodeData:data] andKey:key];
}

+ (NSData *)getWithKey:(NSString *)key
{
    return [Base64 decodeData:[WFFileManager getWithType:WFFilePathTypeDocument andFolder:[self getFolder:key] andKey:key]];
}

+ (void)removeAllCache
{
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:kWFAsynHttpCache_Folder];
}

+ (void)removeAllImageCache
{
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:[self getFolderWithType:WFAsynHttpCacheFolderType_Image]];
}

+ (void)removeWithKey:(NSString *)key
{
    
    if(key == nil || key.length == 0) return;
    [WFFileManager deleteWithType:WFFilePathTypeDocument andFolder:[self getFolder:key] andKey:key];
}

+ (BOOL)isExistWithKey:(NSString *)key
{
    if(key == nil || key.length == 0) return NO;
    return [WFFileManager isExistWityType:WFFilePathTypeDocument andFolder:[self getFolder:key] andKey:key];
}

+ (NSString *)getFolder:(NSString *)key
{
    if(key && [WFAsyncHttpUtil isImageRequest:key])
    {
        return [self getFolderWithType:WFAsynHttpCacheFolderType_Image];
    }
    else
    {
        return [self getFolderWithType:WFAsynHttpCacheFolderType_Other];;
    }
}


+ (NSString *)getFolderWithType:(WFAsynHttpCacheFolderType)type
{
    NSMutableString *folder = [NSMutableString stringWithString:kWFAsynHttpCache_Folder];
    [folder appendString:@"/"];
    switch (type) {
        case WFAsynHttpCacheFolderType_Image:
        {
            [folder appendString:kWFAsynHttpCache_Folder_Image];
            return folder;
            
        }
        case WFAsynHttpCacheFolderType_Other:
        {
            [folder appendString:kWFAsynHttpCache_Folder_Other];
            return folder;
            
        }
        default:
        {
            [folder appendString:kWFAsynHttpCache_Folder_Other];
            return folder;
        }
            
    }
}

@end
