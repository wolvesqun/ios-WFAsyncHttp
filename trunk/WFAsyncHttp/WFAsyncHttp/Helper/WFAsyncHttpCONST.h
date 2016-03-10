//
//  WFAsyncHttpCONST.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWFHttpRequestType_POST     @"POST"
#define kWFHttpRequestType_GET      @"GET"


/**
 *  
 *  @param responseDate 返回的结果数据,如果是json数据，框架会自动转换成NSDictionary 或着 NSArray
 *  @param cache  （当前返回的数据来源-》缓存 | 网络）
 */
typedef void(^BLock_WFRequestDataSuccessCompletion)(id responseDate, NSURLResponse *response, BOOL isCache);
typedef   id(^BLock_WFHandlerDataSuccessCompletion)(id responseDate, NSURLResponse *response, BOOL isCache);
typedef void(^BLock_WFRequestDataPrecentCompletion)(float percent);
typedef void(^BLock_WFRequestDataFailureCompletion)(NSError *error);




@interface WFAsyncHttpCONST : NSObject

@end
