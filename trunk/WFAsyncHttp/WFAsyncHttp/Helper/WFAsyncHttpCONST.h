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


#pragma mark - 数据来源
typedef NS_ENUM(NSUInteger,WFDataFromType)
{
    WFDataFromType_Default,         // *** 没有缓存
    WFDataFromType_LocalCache,      // *** 本地缓存
    WFDataFromType_Memcache,        // *** 内存数据
    WFDataFromType_Net,             // *** 网络请求回来的数据
};


/**
 *  
 *  @param responseDate 返回的结果数据,如果是json数据，框架会自动转换成NSDictionary 或着 NSArray
 *  @param fromType  （当前返回的数据来源-》缓存(本地缓存，内存缓存) | 网络）
 */
typedef void(^BLock_WFRequestDataSuccessCompletion)(id responseDate, NSURLResponse *response, WFDataFromType fromType);
typedef   id(^BLock_WFHandlerDataSuccessCompletion)(id responseDate, NSURLResponse *response, WFDataFromType fromType);
typedef void(^BLock_WFRequestDataPrecentCompletion)(float percent);
typedef void(^BLock_WFRequestDataFailureCompletion)(NSError *error);




@interface WFAsyncHttpCONST : NSObject

@end
