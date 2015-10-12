//
//  WFAsyncHttpUtil.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFAsyncHttpUtil.h"
#import "WFAsyncHttp.h"
#import "WFAsynHttpCacheManager.h"

@implementation WFAsyncHttpUtil

+ (BOOL)handlerParamErrorWithURLString:(NSString *)URLString
                            andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                            andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    if(success == nil || failure == nil || URLString == nil || URLString.length == 0) {
        NSLog(@"======================= 请求参数传入错误 =======================");
        return YES;
    }
    return NO;
}

+ (NSData *)getURLParamWithDict:(NSDictionary *)dict
{
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSString *key in [dict allKeys]) {
        [str appendString:@"&"];
        NSString *value = [dict objectForKey:key];
        value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [str appendFormat:@"%@=%@", [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding], value];
    }
    if(str.length > 0)
    {
        [str deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

+ (NSDictionary *)getUserAgentWithValue:(NSString *)value
{
    if(value == nil || value.length == 0) return nil;
    return [NSDictionary dictionaryWithObjectsAndKeys:value,@"User-Agent", nil];
}

/**
 * userAgent	iPhone Simulator;iPhone OS 8.0
 */
+ (NSString *)getDefaultUserAgent {
    // *** 获取系统版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDic objectForKey:@"CFBundleVersion"];//Version
    NSString *app_Build = [infoDic objectForKey:@"CFBundleShortVersionString"];//Build
    
    // *** 设置信息
    NSString *model = [UIDevice currentDevice].model;
    NSString *systemName = [UIDevice currentDevice].systemName;
    NSString *systemVertion = [UIDevice currentDevice].systemVersion;
    NSString *iphoneInfo = [NSString stringWithFormat:@"%@;%@ %@",model, systemName, systemVertion];
    
    NSString *app_Name = [infoDic objectForKey:@"CFBundleDisplayName"];
    if(app_Name == nil)
    {
        app_Name = @"app_Name";
    }
    NSString *userAgent = [NSString stringWithFormat:@"%@-%@-APP/%@(%@;Build/%@)",  kWFWFAsyncHttp_CompanyName , app_Name, app_Build, iphoneInfo , app_Version];
    return [userAgent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 请求结果处理
+ (void)handleSuccessWithData:(NSData *)data andSuccess:(WFSuccessAsyncHttpDataCompletion)success
{
    if(success)
    {
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error == nil)
        {
            success(jsonObject);
        }
        else
        {
            success(data);
        }
        
    }
}

+ (void)handleFailureWithError:(NSError *)error andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    if(failure)
    {
        failure(error);
    }
}


+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success
{
    BOOL b = [WFAsynHttpCacheManager isExistWithKey:key];
    if(b && key && key.length > 0)
    {
        NSData *cacheData = [WFAsynHttpCacheManager getWithKey:key];
        [self handleSuccessWithData:cacheData andSuccess:success];
    }
    return b;
}

@end




