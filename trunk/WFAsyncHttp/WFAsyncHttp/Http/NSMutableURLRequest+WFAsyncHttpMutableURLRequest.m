//
//  NSMutableURLRequest+WFAsyncHttpMutableURLRequest.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-10.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "NSMutableURLRequest+WFAsyncHttpMutableURLRequest.h"
#import "WFAsyncHttpUtil.h"

@implementation NSMutableURLRequest (WFAsyncHttpMutableURLRequest)

- (void)addHttpHeaderWithRequest:(NSMutableDictionary *)headers
{
    if(headers == nil)
    {
        headers = [NSMutableDictionary dictionary];
    }
    if([headers objectForKey:@"User-Agent"] == nil)
    {
        [headers setObject:[WFAsyncHttpUtil getDefaultUserAgent] forKey:@"User-Agent"];
    }
    for (NSString *key in headers.allKeys) {
        NSString *value = [headers objectForKey:key];
        [self setValue:value forHTTPHeaderField:key];
    }
    
    
}

- (void)addParamWithDict:(NSDictionary *)params
{
    if(params && params.allKeys.count > 0)
    {
        [self setHTTPBody:[WFAsyncHttpUtil getURLParamWithDict:params]];
    }
}

@end
