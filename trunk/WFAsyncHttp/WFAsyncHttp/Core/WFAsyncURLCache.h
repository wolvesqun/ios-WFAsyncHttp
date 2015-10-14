//
//  WFAsyncURLCache.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-13.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFAsyncURLCache : NSURLCache

+ (void)setURLCache;

+ (BOOL)checkURLCache:(NSString *)Key;

+ (NSString *)buildURLCacheKey:(NSString *)URLString;

+ (BOOL)isWebFileRequest:(NSString *) URLString;

@end
