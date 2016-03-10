//
//  WFBaseRequest.h
//  WFAsyncHttp
//
//  Created by mba on 15/3/1.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAsyncHttpCONST.h"

@interface WFBaseRequest : NSObject

#pragma mark - 网络请求接口
+ (void)requestDataWithURLString:(NSString *)URLString
                       andParams:(NSDictionary *)params
                       andHeader:(NSDictionary *)header
                    andUserAgent:(NSString *)userAgent
                   andHttpMethod:(NSString *)httpMethod
                      andSuccess:(void(^)(NSData *data, NSURLResponse *response))success
                      andFailure:(void(^)(NSError * error))failure;


@end
