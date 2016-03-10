//
//  WFMemcacheManager.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "WFMemcacheManager.h"
#import <objc/runtime.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

@interface WFMemcacheManager ()

@property (strong, nonatomic) NSMutableDictionary *storageDict;

@end

@implementation WFMemcacheManager

+ (id)getInstance
{
    static WFMemcacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(manager == nil)
        {
            manager = [[self alloc] init];
            manager.storageDict = [NSMutableDictionary dictionary];
        }
    });
    return manager;
}

+ (void)addWithData:(id)data andKey:(NSString *)key andExpiredTime:(NSTimeInterval)expiredTime
{
    [[self getInstance] saveWithData:data andKey:key andExpiredTime:expiredTime];
}
+ (id)getCacheWithKey:(NSString *)key
{
    return [[self getInstance] _getCacheWithKey:key];
}

+ (void)clearWithKey:(NSString *)key
{
    [[self getInstance] deleteWithKey:key];
}

#pragma mark - 
- (void)saveWithData:(id)data andKey:(NSString *)key andExpiredTime:(NSTimeInterval)expiredTime
{
    if(data != nil && key != nil && [self.storageDict objectForKey:key] == nil)
    {
        [self.storageDict setObject:data forKey:key];
        if(expiredTime > 0) // 时间失效就清除缓存
        {
            [self performSelector:@selector(deleteWithKey:) withObject:key afterDelay:expiredTime];
        }
    }
//    NSLog(@"当前使用内存 %f", [self usedMemory]);
}

- (id)_getCacheWithKey:(NSString *)key
{
    if(key) return [self.storageDict objectForKey:key];
    return nil;
}

- (void)deleteWithKey:(NSString *)key
{
    if(key)
    {
        [self.storageDict removeObjectForKey:key];
    }
}

- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}


@end
