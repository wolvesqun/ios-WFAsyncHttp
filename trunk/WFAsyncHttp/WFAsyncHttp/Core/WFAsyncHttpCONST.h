//
//  WFAsyncHttpCONST.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWFHttpRequestType_POST @"POST"
#define kWFHttpRequestType_GET @"GET"
#define kWFHttpRequestType_DELETE @"DELETE"


typedef void(^WFSuccessAsyncHttpDataCompletion)(id responseObject);
typedef void(^WFPercentAsyncHttpDataCompletion)(float percent);
typedef void(^WFFailureAsyncHttpDataCompletion)(NSError *error);

typedef NS_ENUM(NSUInteger,WFAsyncCachePolicy)
{
    WFAsyncCachePolicyType_Default = 0, // *** 不提供缓存
    WFAsyncCachePolicyType_ReturnCache_DontLoad = 1, // *** 返回缓存
    WFAsyncCachePolicyType_ReturnCache_DidLoad = 2,  // *** 返回缓存并且加载
};


@interface WFAsyncHttpCONST : NSObject

@end
