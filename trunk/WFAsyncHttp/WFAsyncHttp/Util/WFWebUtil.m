//
//  WFWebUtil.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "WFWebUtil.h"

@implementation WFWebUtil

+ (BOOL)handlerParamErrorWithURLString:(NSString *)URLString
                            andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                            andFailure:(BLock_WFRequestDataFailureCompletion)failure
{
    if(success == nil || failure == nil || URLString == nil || URLString.length == 0) {
        NSLog(@"======================= request param is error =======================");
        return YES;
    }
    return NO;
}

+ (NSData *)convertToDataWithDict:(NSDictionary *)dict
{
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSString *key in [dict allKeys]) {
        [str appendString:@"&"];
        NSString *value = [dict objectForKey:key];
        value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *decodeKey = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [str appendFormat:@"%@=%@", [decodeKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if(str.length > 0)
    {
        [str deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}


/**
 * userAgent	iPhone Simulator;iPhone OS 8.0
 */
//+ (NSString *)getDefaultUserAgent {
//    // *** 获取系统版本号
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Version = [infoDic objectForKey:@"CFBundleVersion"];//Version
//    NSString *app_Build = [infoDic objectForKey:@"CFBundleShortVersionString"];//Build
//
//    // *** 设置信息
//    NSString *model = [UIDevice currentDevice].model;
//    NSString *systemName = [UIDevice currentDevice].systemName;
//    NSString *systemVertion = [UIDevice currentDevice].systemVersion;
//    NSString *iphoneInfo = [NSString stringWithFormat:@"%@;%@ %@",model, systemName, systemVertion];
//
//    // *** 获取appname信息
//    NSString *app_Name = [infoDic objectForKey:@"CFBundleDisplayName"];
//    if(app_Name == nil)
//    {
//        app_Name = @"app_Name";
//    }
//    NSString *userAgent = [NSString stringWithFormat:@"%@-%@-APP/%@(%@;Build/%@)",  kWFWFAsyncHttp_CompanyName , app_Name, app_Build, iphoneInfo , app_Version];
//
//    return [userAgent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}



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

+ (NSString *)encodeUTF_8:(NSString *)source
{
    if(source == nil) return source;
    return [source stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+ (NSString *)decodeUTF_8:(NSString *)source
{
    if(source == nil) return source;
    return [source stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
