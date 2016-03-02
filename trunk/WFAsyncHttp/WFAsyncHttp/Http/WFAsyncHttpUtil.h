//
//  WFAsyncHttpUtil.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//
//  Github : https://github.com/wolvesqun/IOS-WFAsyncHttp
//  当前版本 2.0.1



#import <UIKit/UIKit.h>
#import "WFAsyncHttpCONST.h"

@interface WFAsyncHttpUtil : NSObject

+ (BOOL)handlerParamErrorWithURLString:(NSString *)URLString
                            andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                            andFailure:(WFFailureAsyncHttpDataCompletion)failure;


+ (NSData *)getURLParamWithDict:(NSDictionary *)dict;

+ (NSDictionary *)getUserAgentWithValue:(NSString *)value;

/**
 *  获取默认user-agent
 */
//+ (NSString *)getDefaultUserAgent;



//+ (BOOL)isExistCacheWithKey:(NSString *)key;
//
//+ (void)saveCache

+ (BOOL)isImageRequest:(NSString *)URLString;
+ (BOOL)isWebFileRequest:(NSString *) URLString;

+ (NSString *)encodeUTF_8:(NSString *)source;
+ (NSString *)decodeUTF_8:(NSString *)source;


@end
