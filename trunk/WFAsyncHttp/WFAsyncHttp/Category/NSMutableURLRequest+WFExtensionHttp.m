//
//  NSMutableURLRequest+WFExtensionHttp.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "NSMutableURLRequest+WFExtensionHttp.h"
#import "WFWebUtil.h"

@implementation NSMutableURLRequest (WFExtensionHttp)

- (void)addHttpHeader:(NSDictionary *)headers
{
    if(headers && headers.count > 0)
    {
        for (NSString *key in headers.allKeys) {
            
            if([key isEqualToString:@"User-Agent"] || [key isEqualToString:@"user-agent"])
            {
                break;
            }
            NSString *value = [headers objectForKey:key];
            NSString *decodeKey = [WFWebUtil decodeUTF_8:key];
            NSString *decodeValue = [WFWebUtil decodeUTF_8:value];
            
            [self setValue:[WFWebUtil encodeUTF_8:decodeKey] forHTTPHeaderField:[WFWebUtil encodeUTF_8:decodeValue]];
        }
    }
}


- (void)addUserAgent:(NSString *)userAgent
{
    if(userAgent && [userAgent isKindOfClass:[NSString class]] && userAgent.length)
    {
        [self setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
}

- (void)addParamWithDict:(NSDictionary *)params
{
    if(params && params.allKeys.count > 0)
    {
        [self setHTTPBody:[WFWebUtil convertToDataWithDict:params]];
    }
}

@end
