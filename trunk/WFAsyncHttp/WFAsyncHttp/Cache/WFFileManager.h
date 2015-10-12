//
//  WFFileManager.h
//  testServerFramework
//
//  Created by wolvesqun on 13-3-21.
//  Copyright (c) 2013年 wolf. All rights reserved.
//



#import <Foundation/Foundation.h>


/*** 文件路径类型 ***/
typedef enum : NSUInteger {
    // *** document
    WFFilePathTypeDocument = 0,
    // *** cached
    WFFilePathTypeCached = 1,
    // *** temp
    WFFilePathTypeTemp = 2
} WFFilePathType;


/**
 *  文件管理器
 */
@interface WFFileManager : NSObject



#pragma mark - 删除文件
+ (void)deleteWithType:(WFFilePathType)type andFolder:(NSString *)folder andKey:(NSString *)key;

#pragma mark - 删除所有数据
+ (void)deleteWithType:(WFFilePathType)type andFolder:(NSString *)folder;

#pragma mark - 保存数据 -》有文件夹
+ (void)saveWithType:(WFFilePathType)type andFolder:(NSString *)folder andData:(id)data andKey:(NSString *)key;

#pragma mark - 获取数据 -> 从文件夹获取数据
+ (id)getWithType:(WFFilePathType)type andFolder:(NSString *)folder andKey:(NSString *)key;
+ (float)getFileArraySizeWithType:(WFFilePathType)type andFolder:(NSString *)folder;

+ (BOOL)isExistWityType:(WFFilePathType)type andFolder:(NSString *)folder andKey:(NSString *)key;
@end
