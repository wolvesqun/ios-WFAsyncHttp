//
//  WFBaseRequest.m
//  WFAsyncHttp
//
//  Created by mba on 15/3/1.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "WFBaseRequest.h"
#import "WFWebUtil.h"
#import "NSMutableURLRequest+WFExtensionHttp.h"

@implementation WFBaseRequest


#pragma mark - 请求数据
+ (NSURLSessionDataTask *)requestDataWithURLString:(NSString *)URLString
                       andParams:(NSDictionary *)params
                       andHeader:(NSDictionary *)header
                    andUserAgent:(NSString *)userAgent
                   andHttpMethod:(NSString *)httpMethod
                      andSuccess:(void(^)(NSData *data, NSURLResponse *response))success
                      andFailure:(void(^)(NSError * error))failure
{
    
    if(success == nil || failure == nil )
    {
        @throw [NSException exceptionWithName:@"参数为空"
                                       reason:[NSString stringWithFormat:@"WFBaseRequest里回调的block为空，你还还没实现, 请求地址 %@", URLString]
                                     userInfo:nil];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:10];
    [request setHTTPMethod:httpMethod];
    [request addParamWithDict:params];
    [request addHttpHeader:header];
    [request addUserAgent:userAgent];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error)
                                      {
                                          if(error)
                                          {
                                              failure(error);
                                          }
                                          else
                                          {
                                              success(data, response);
                                          }
                                      }];
    [dataTask resume];
    return dataTask;
//    if([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)
//    {
//        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
//                                                    completionHandler:^(NSData * _Nullable data,
//                                                                        NSURLResponse * _Nullable response,
//                                                                        NSError * _Nullable error)
//                                          {
//                                              if(error)
//                                              {
//                                                    failure(error);
//                                              }
//                                              else
//                                              {
//                                                    success(data, response);
//                                              }
//                                          }];
//        [dataTask resume];
//    }
//    else
//    {
//        // *** start
//        [NSURLConnection sendAsynchronousRequest:request
//                                           queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
//         {
//             if(connectionError)
//             {
//                 failure(connectionError);
//             }
//             else
//             {
//                 success(data, response);
//             }
//         }];
//    }
}

+ (NSURLSessionDataTask *)requestUsingSessionWithURLString:(NSString *)URLString
                       andParams:(NSDictionary *)params
                       andHeader:(NSDictionary *)header
                    andUserAgent:(NSString *)userAgent
                   andHttpMethod:(NSString *)httpMethod
                      andSuccess:(void(^)(NSData *data, NSURLResponse *response))success
                      andFailure:(void(^)(NSError * error))failure
{
    
    if(success == nil || failure == nil )
    {
        @throw [NSException exceptionWithName:@"参数为空"
                                       reason:[NSString stringWithFormat:@"WFBaseRequest里回调的block为空，你还还没实现, 请求地址 %@", URLString]
                                     userInfo:nil];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:10];
    [request setHTTPMethod:httpMethod];
    [request addParamWithDict:params];
    [request addHttpHeader:header];
    [request addUserAgent:userAgent];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error)
                                      {
                                          if(error)
                                          {
                                              failure(error);
                                          }
                                          else
                                          {
                                              success(data, response);
                                          }
                                      }];
    [dataTask resume];
    return dataTask;
}



@end
