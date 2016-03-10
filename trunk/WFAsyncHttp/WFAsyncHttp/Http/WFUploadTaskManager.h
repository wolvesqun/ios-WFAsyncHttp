//
//  WFUploadTaskManager.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/10.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  上传任务相关
 */
@interface WFUploadTaskManager : NSObject

#pragma mark - 上传数据
+ (void)uploadDataWithURLString:(NSString *)URLString
                      andHeader:(NSDictionary *)header
                       andParam:(NSDictionary *)param
                   andUserAgent:(NSString *)userAgent
                     andSuccess:(void(^)(NSData *data, NSURLResponse *response))success
                     andFailure:(void(^)(NSError * error))failure;

#pragma mark - 上传文件
+ (void)uploadFileWithURLString:(NSString *)URLString
                      andHeader:(NSDictionary *)header
                    andFromFile:(NSURL *)fromFile
                   andUserAgent:(NSString *)userAgent
                     andSuccess:(void(^)(NSData *data, NSURLResponse *response))success
                     andFailure:(void(^)(NSError * error))failure;

@end
