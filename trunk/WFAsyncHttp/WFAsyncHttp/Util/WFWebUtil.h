//
//  WFWebUtil.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAsyncHttpCONST.h"

@interface WFWebUtil : NSObject

+ (BOOL)handlerParamErrorWithURLString:(NSString *)URLString
                            andSuccess:(BLock_WFRequestDataSuccessCompletion)success
                            andFailure:(BLock_WFRequestDataFailureCompletion)failure;


+ (NSData *)convertToDataWithDict:(NSDictionary *)dict;


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
