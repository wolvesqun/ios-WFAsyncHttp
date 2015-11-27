//
//  WFFileManager.m
//  testServerFramework
//
//  Created by wolvesqun on 13-3-21.
//  Copyright (c) 2013年 wolf. All rights reserved.
//

/*** document路径 ***/
#define kWF_DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/*** Cached路径 ***/
#define kWF_CACHED_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/*** temp路径 ***/
#define kWF_TEMP_PATH [NSHomeDirectory() stringByAppendingFormat:@"/tmp"]

#import "WFFileManager.h"
#include "sys/stat.h"
#import "Base64.h"

#define FILE_MANAGER [NSFileManager defaultManager]

@implementation WFFileManager

#pragma mark - 获取文件大小 -> 采用c语言获取文件大小 -》 性能比oc自带的高
+ (long long)getFileSizeAtPath:(NSString *)filePath
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size / 1024.0;
    }
    return 0;
}

/**
 *  文件夹里面所有文件大小
 */
+ (float)getFileArraySizeWithType:(WFFilePathType)type andFolder:(NSString *)folder
{
    
    NSString *forderPath = [self createFolderWithType:type andFolder:folder];
    float fileSize = 0;
    NSArray *tempFileArray = [FILE_MANAGER subpathsAtPath:forderPath];
    for (NSString *andKey in tempFileArray) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",forderPath, andKey];
        fileSize += [self getFileSizeAtPath:filePath];
    }
    return fileSize;
}

#pragma mark -  删除文件
+ (void)deleteWithType:(WFFilePathType)type andKey:(NSString *)key
{
    
    // *** 文件路径
    NSString *filePath = [self filePathWithType:type andKey:key];
    
    // *** 判断文件是否存在
    if([FILE_MANAGER fileExistsAtPath:filePath]) {
        // *** 删除文件
        if(![FILE_MANAGER removeItemAtPath:filePath error:nil]) {
            NSLog(@"删除文件失败");
        }
    }
}

#pragma mark - 删除文件
+ (void)deleteWithType:(WFFilePathType)type andFolder:(NSString *)folder andKey:(NSString *)key {
    // *** 文件路径
   
    NSString *filePath =  [self filePathWithType:type andFolder:folder andKey:key];
    
    // *** 判断文件是否存在
    if([FILE_MANAGER fileExistsAtPath:filePath]) {
        // *** 删除文件
        if(![FILE_MANAGER removeItemAtPath:filePath error:nil]) {
            NSLog(@"删除文件失败");
        }
    }
}

#pragma mark - 删除所有数据
+ (void)deleteWithType:(WFFilePathType)type andFolder:(NSString *)folder

{
    // *** 为空则直接返回
    if(folder == nil || [folder isEqualToString:@""]) return;
    
    // *** 构建删除路径
    
    NSString *imageDir = [self filePathWithType:type andFolder:folder andKey:nil];
    
    // *** 删除文件夹
    if(folder != nil || ![folder isEqualToString:@""]) {
        BOOL isDir = NO;
        BOOL existed = [FILE_MANAGER fileExistsAtPath:imageDir isDirectory:&isDir];
        if ( isDir == YES && existed == YES)
        {
            [FILE_MANAGER removeItemAtPath:imageDir error:nil];
        }
    }
}

#pragma mark - 保存数据 -》有文件夹
+ (void)saveWithType:(WFFilePathType)type andFolder:(NSString *)folder andData:(id)data andKey:(NSString *)key
{
    if(![data respondsToSelector:@selector(encodeWithCoder:)] || ![data respondsToSelector:@selector(initWithCoder:)])
    {
        return;
    }
    if([data isKindOfClass:[NSData class]])
    {
        [NSKeyedArchiver archiveRootObject:[Base64 encodeData:data] toFile:[self filePathWithType:type andFolder:folder andKey:key]];
    }
    else
    {
        [NSKeyedArchiver archiveRootObject:data toFile:[self filePathWithType:type andFolder:folder andKey:key]];
    }
    
}

#pragma mark - 获取数据 -> 从文件夹获取数据
+ (id)getWithType:(WFFilePathType)type andFolder:(NSString *)folder andKey:(NSString *)key {
    id data = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePathWithType:type andFolder:folder andKey:key]];
    if(data && [data isKindOfClass:[NSData class]])
    {
        return [Base64 decodeData:data];
    }
    else
    {
        return data;
    }
}

#pragma mark - 构建文件夹、文件路径 -> folderName不为空则创建，为空则创建
+ (NSString *)createFolderWithType:(WFFilePathType)type andFolder:(NSString *)folder {
    // *** 构建文件夹路径
    NSString *imageDir;
    switch (type) {
        case WFFilePathTypeDocument:
        {
            if(folder != nil && ![folder isEqualToString:@""]) {
                imageDir = [NSString stringWithFormat:@"%@/%@",kWF_DOCUMENT_PATH, folder];
            } else {
                imageDir = kWF_DOCUMENT_PATH;
            }
            
            break;
        }
        case WFFilePathTypeCached:
        {
            if(folder != nil || ![folder isEqualToString:@""]) {
                imageDir = [NSString stringWithFormat:@"%@/%@",kWF_CACHED_PATH, folder];
            } else {
                imageDir = kWF_CACHED_PATH;
            }
            break;
        }
        case WFFilePathTypeTemp:
        {
            if(folder != nil || ![folder isEqualToString:@""]) {
                imageDir = [NSString stringWithFormat:@"%@/%@",kWF_TEMP_PATH, folder];
            } else {
                imageDir = kWF_TEMP_PATH;
            }
            break;
        }
    }
    
    // *** 文件名不为空时创建文件夹
    if(folder != nil || ![folder isEqualToString:@""]) {
        BOOL isDir = NO;
        BOOL existed = [FILE_MANAGER fileExistsAtPath:imageDir isDirectory:&isDir];
        if ( !(isDir == YES && existed == YES) )
        {
            [FILE_MANAGER createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    return imageDir;
}

+ (NSString *)filePathWithType:(WFFilePathType)type andKey:(NSString *)key {
//    return [self filePathWithFolder:nil filePathType:filePathType andKey:andKey];
    return [self filePathWithType:type andFolder:nil andKey:key];
}

#pragma mark - 构建文件路径 -》有文件夹
+ (NSString *)filePathWithType:(WFFilePathType)type andFolder:(NSString *)folder andKey:(NSString *)key {
    
    // *** 构建文件夹路径前缀
    NSString *preffixPath = [self createFolderWithType:type andFolder:folder];
    
    if(key == nil || [key isEqualToString:@""]) {
        return preffixPath;
    }
    else {
        // *** 构建文件路径
        NSString *filePath = [preffixPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", (unsigned long)[key hash]]];
        return filePath;
    }
}

/**
 *  是否存在这个文件
 */
+ (BOOL)isExistWityType:(WFFilePathType)type andFolder:(NSString *)folder andKey:(NSString *)key
{
    NSString *filePath = [self filePathWithType:type andFolder:folder andKey:key];
    if([FILE_MANAGER fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

@end
