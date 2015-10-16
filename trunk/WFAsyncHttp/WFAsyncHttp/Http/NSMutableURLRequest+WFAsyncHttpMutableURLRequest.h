//
//  NSMutableURLRequest+WFAsyncHttpMutableURLRequest.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (WFAsyncHttpMutableURLRequest)

- (void)addHttpHeaderWithRequest:(NSMutableDictionary *)headers;

- (void)addParamWithDict:(NSDictionary *)params;

@end
