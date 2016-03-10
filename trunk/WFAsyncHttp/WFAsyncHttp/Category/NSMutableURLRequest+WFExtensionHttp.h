//
//  NSMutableURLRequest+WFExtensionHttp.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (WFExtensionHttp)

- (void)addHttpHeader:(NSDictionary *)headers;

- (void)addUserAgent:(NSString *)userAgent;

- (void)addParamWithDict:(NSDictionary *)params;

@end
