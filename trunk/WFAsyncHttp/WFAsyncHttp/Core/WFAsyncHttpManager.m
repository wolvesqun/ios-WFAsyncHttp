//
//  WFAsyncHttpManager.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-9.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#warning 根据项目需要设置最小连接数
#define kWFAsyncHttpClient_MIN_Count 10 // 最小WFAsyncHttpClient线程数（当使用WFAsyncHttpManager）

#import "WFAsyncHttpManager.h"
#import "WFAsyncHttpClient.h"

@interface WFAsyncHttpClientArray : NSObject

@property (strong, nonatomic) NSMutableArray *freeHttpClientArray;
@property (strong, nonatomic) NSMutableArray *taskHttpClientArray;

- (id)getItem;

- (void)releaseItem:(id)item;

@end

@implementation WFAsyncHttpClientArray

- (instancetype)init
{
    if(self = [super init])
    {
        self.freeHttpClientArray = [NSMutableArray array];
        self.taskHttpClientArray = [NSMutableArray array];
        for (int i = 0; i < kWFAsyncHttpClient_MIN_Count; i ++) {
            [self addItem];
        }
    }
    return self;
}

- (void)addItem
{
    [self.freeHttpClientArray addObject:[[WFAsyncHttpClient alloc] init]];
}

- (id)getItem
{
    if(self.freeHttpClientArray.count == 0)
    {
        [self addItem];
    }
    
    id item = [self.freeHttpClientArray firstObject];
    [self.freeHttpClientArray removeObject:item];
    [self.taskHttpClientArray addObject:item];
//    static int index = 0;
//    index ++;
//    NSLog(@"*********** 添加 task = %d",index);
    return item;
}

- (void)releaseItem:(id)item
{
    [self.taskHttpClientArray removeObject:item];
    [self.freeHttpClientArray addObject:item];
//    static int index = 0;
//    index  ++ ;
//    NSLog(@"==========  释放 task = %d, all = %d", index, self.taskHttpClientArray.count);
}

@end

@interface WFAsyncHttpManager ()
{
    WFAsyncHttpClientArray *httpClientArray;
}

@end

@implementation WFAsyncHttpManager

- (id)init
{
    if(self = [super init])
    {
        httpClientArray = [[WFAsyncHttpClientArray alloc] init];
    }
    return self;
}

- (WFAsyncHttpClient *)getHttpClient
{
    WFAsyncHttpClient *client = nil;
    @synchronized(httpClientArray)
    {
        client = [httpClientArray getItem];
    }
    return client;
}

- (void)releaseHttpClient:(WFAsyncHttpClient *)httpClient
{
    @synchronized(httpClientArray)
    {
        [httpClientArray releaseItem:httpClient];
    }
}


+ (id)shareInstance
{
    static WFAsyncHttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(manager == nil)
        {
            manager = [WFAsyncHttpManager new];
        }
    });
    return manager;
}

#pragma mark - GET 请求

+ (void)GET_WithURLString:(NSString *)URLString
               andHeaders:(NSDictionary *)headers
           andCachePolicy:(WFAsyncCachePolicy)cachePolicy
               andSuccess:(WFSuccessAsyncHttpDataCompletion)successBlock
               andFailure:(WFFailureAsyncHttpDataCompletion)failureBlock
{
    WFAsyncHttpClient *client = [[self shareInstance] getHttpClient];
    [client addHttpHeaderWihtDict:headers];
    [client setCachePolicy:cachePolicy];
    [client GET_WithURLString:URLString andSuccess:^(id responseObject)
     {
         if(successBlock) successBlock(responseObject);
         [[WFAsyncHttpManager shareInstance] releaseHttpClient:client];
         
     } andFailure:^(NSError *error) {
         if(failureBlock) failureBlock(error);
         [[WFAsyncHttpManager shareInstance] releaseHttpClient:client];
     }];
}

+ (void)GET_WithURLString:(NSString *)URLString
           andCachePolicy:(WFAsyncCachePolicy)cachePolicy
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self GET_WithURLString:URLString andHeaders:nil andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}

+ (void)GET_WithURLString:(NSString *)URLString
               andSuccess:(WFSuccessAsyncHttpDataCompletion)success
               andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self GET_WithURLString:URLString andHeaders:nil andCachePolicy:WFAsyncCachePolicyType_Default andSuccess:success andFailure:failure];
}

#pragma mark - POST 请求
+ (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
                andHeaders:(NSDictionary *)headers
            andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                andSuccess:(WFSuccessAsyncHttpDataCompletion)successBlock
                andFailure:(WFFailureAsyncHttpDataCompletion)failureBlock
{
    WFAsyncHttpClient *client = [[self shareInstance] getHttpClient];
    [client addHttpHeaderWihtDict:headers];
    [client setCachePolicy:cachePolicy];
    [client POST_WithURLString:URLString andParams:params andSuccess:^(id responseObject) {
        if(successBlock) successBlock(responseObject);
        [[WFAsyncHttpManager shareInstance] releaseHttpClient:client];
    } andFailure:^(NSError *error) {
        if(failureBlock) failureBlock(error);
        [[WFAsyncHttpManager shareInstance] releaseHttpClient:client];
    }];
}

+ (void)POST_WithURLString:(NSString *)URLString
                 andParams:(NSDictionary *)params
            andCachePolicy:(WFAsyncCachePolicy)cachePolicy
                andSuccess:(WFSuccessAsyncHttpDataCompletion)success
                andFailure:(WFFailureAsyncHttpDataCompletion)failure
{
    [self POST_WithURLString:URLString andParams:params andHeaders:nil andCachePolicy:cachePolicy andSuccess:success andFailure:failure];
}

@end
