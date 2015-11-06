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
        
        
        NSString *decodeKey = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *decodeValue = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [self setValue:[decodeValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField:[decodeKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
