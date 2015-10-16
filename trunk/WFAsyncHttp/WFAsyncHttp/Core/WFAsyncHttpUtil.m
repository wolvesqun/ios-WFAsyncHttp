//
//  WFAsyncHttpUtil.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFAsyncHttpUtil.h"
#import "WFAsyncHttp.h"
#import "WFAsyncHttpCacheManager.h"

@implementation WFAsyncHttpUtil

+ (BOOL)handlerParamErrorWithURLString:(NSString *)URLString
                            andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                            andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    if(success == nil || failure == nil || URLString == nil || URLString.length == 0) {
        NSLog(@"======================= request param is error =======================");
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
    
    // *** 获取appname信息
    NSString *app_Name = [infoDic objectForKey:@"CFBundleDisplayName"];
    if(app_Name == nil)
    {
        app_Name = @"app_Name";
    }
    NSString *userAgent = [NSString stringWithFormat:@"%@-%@-APP/%@(%@;Build/%@)",  kWFWFAsyncHttp_CompanyName , app_Name, app_Build, iphoneInfo , app_Version];
    
    return [userAgent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 请求结果处理
+ (void)handleRequestResultWithKey:(NSString *)key
                           andData:(NSData *)data
                    andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                        andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                          andError:(NSError *)error
                        andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    if(error)
    {
        if(failure) failure(error);
    }
    else
    {
        // *** save data
        if(cachePolicy != WFAsyncCachePolicyType_Default)
        {
            [WFAsyncHttpCacheManager saveWithData:data andKey:key];
        }
        [self handleDataSuccess:data andSuccess:success];
    }
}
// - request success
+ (void)handleRequestResultWithKey:(NSString *)key
                           andData:(NSData *)data
                    andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                        andSuccess:(WFSuccessAsyncHttpDataCompletion)success
{
    [self handleRequestResultWithKey:key
                             andData:data
                      andCachePolicy:cachePolicy
                          andSuccess:success
                            andError:nil
                          andFailure:nil];
}
// - request error
+ (void)handleRequestResultWithError:(NSError *)error
                          andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self handleRequestResultWithKey:nil
                             andData:nil
                      andCachePolicy:WFAsyncCachePolicyType_Default
                          andSuccess:nil
                            andError:error
                          andFailure:failure];
}


+ (void)handleDataSuccess:(NSData *)data andSuccess:(WFSuccessAsyncHttpDataCompletion)success
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

+ (void)handleDataFailure:(NSError *)error andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    if(failure) failure(error);
}


+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success
{
    BOOL b = [WFAsyncHttpCacheManager isExistWithKey:key];
    if(b && key && key.length > 0)
    {
        NSData *cacheData = [WFAsyncHttpCacheManager getWithKey:key];
        [self handleDataSuccess:cacheData andSuccess:success];
    }
    return b;
}

+ (BOOL)handleCacheWithKey:(NSString *)key andSuccess:(WFSuccessAsyncHttpDataCompletion)success andCachePolicy:(WFAsyncCachePolicy)cachePolicy
{
    switch (cachePolicy) {
        case WFAsyncCachePolicyType_ReturnCache_DidLoad:
        {
            [WFAsyncHttpUtil handleCacheWithKey:key andSuccess:success];
            break;
        }
        case WFAsyncCachePolicyType_ReturnCache_DontLoad:
        {
            if([WFAsyncHttpUtil handleCacheWithKey:key andSuccess:success])
            {
                return YES;
            }
            break;
        }
        case WFAsyncCachePolicyType_Reload_IgnoringLocalCache:
        {
            
            break;
        }
            
            
        default:
            break;
    }
    return NO;
}

+ (BOOL)isImageRequest:(NSString *)URLString
{
    NSRange pngRange = [URLString rangeOfString:@".png"];
    NSRange gifRange = [URLString rangeOfString:@".gif"];
    NSRange jpgRange = [URLString rangeOfString:@".jpg"];
    NSRange jpegRange = [URLString rangeOfString:@".jpeg"];
    NSRange bmpRange = [URLString rangeOfString:@".bmp"];
    if(pngRange.length > 0 || gifRange.length > 0 || jpegRange.length > 0 || jpgRange.length > 0 || bmpRange.length > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isWebFileRequest:(NSString *) URLString
{
    if([URLString rangeOfString:@".css"].length > 0 || [URLString rangeOfString:@".js"].length > 0)
    {
        return YES;
    }
    return NO;
}

@end




