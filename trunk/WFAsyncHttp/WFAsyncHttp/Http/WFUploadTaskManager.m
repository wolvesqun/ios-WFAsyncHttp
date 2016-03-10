//
//  WFUploadTaskManager.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/10.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "WFUploadTaskManager.h"
#import "NSMutableURLRequest+WFExtensionHttp.h"

@implementation WFUploadTaskManager

#pragma mark - 上传数据
+ (void)uploadDataWithURLString:(NSString *)URLString
                      andHeader:(NSDictionary *)header
                       andParam:(NSDictionary *)param
                   andUserAgent:(NSString *)userAgent
                     andSuccess:(void(^)(NSData *data, NSURLResponse *response))success
                     andFailure:(void(^)(NSError * error))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [request addHttpHeader:header];
    [request addUserAgent:userAgent];
    [request addParamWithDict:param];
    
    [session uploadTaskWithRequest:request
                          fromData:nil
                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
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
}

#pragma mark - 上传文件
+ (void)uploadFileWithURLString:(NSString *)URLString
                      andHeader:(NSDictionary *)header
                    andFromFile:(NSURL *)fromFile
                   andUserAgent:(NSString *)userAgent
                     andSuccess:(void(^)(NSData *data, NSURLResponse *response))success
                     andFailure:(void(^)(NSError * error))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [request addUserAgent:userAgent];
    [request addHttpHeader:header];
    
    [session uploadTaskWithRequest:request
                          fromFile:fromFile
                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
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
    
}

@end
