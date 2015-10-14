//
//  WFAsyncURLCache.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-13.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "WFAsyncURLCache.h"
#import "WFAsyncHttpUtil.h"
#import "WFAsyncHttp.h"
#import "WFAsynHttpCacheManager.h"

@interface WFAsyncURLCacheData : NSObject<NSCoding>

@property (strong, nonatomic) NSString *MIMEType;
@property (strong, nonatomic) NSString *textEncodingName;
@property (strong, nonatomic) NSData *data;

@end

@implementation WFAsyncURLCacheData

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.MIMEType = [aDecoder decodeObjectForKey:@"MIMEType"];
        self.textEncodingName = [aDecoder decodeObjectForKey:@"textEncodingName"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.MIMEType forKey:@"MIMEType"];
    [aCoder encodeObject:self.textEncodingName forKey:@"textEncodingName"];
    [aCoder encodeObject:self.data forKey:@"data"];
}

@end

@interface WFAsyncURLCache ()

@property(nonatomic, strong) NSMutableDictionary *responseDictionary;

@end

@implementation WFAsyncURLCache

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime
{
    if (self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
        self.responseDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

+ (void)setURLCache
{
    static WFAsyncURLCache *urlCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(urlCache == nil) {
            urlCache = [[WFAsyncURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                         diskCapacity:200 * 1024 * 1024
                                                             diskPath:nil
                                                            cacheTime:0];
        }
    });
    [WFAsyncURLCache setSharedURLCache:urlCache];
}

#pragma mark - 会请求这个
- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    NSString *URLString = request.URL.absoluteString;
    @try {
        if([WFAsyncURLCache isWebFileRequest:URLString] || [WFAsyncHttpUtil isImageRequest:URLString])
        {
            return [self myCachedResponseForRequest:request];
        }
        return [self cachedResponseForRequest:request];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        
    }
    
}

- (NSCachedURLResponse *)myCachedResponseForRequest:(NSURLRequest *)request
{
    NSString *URLString = request.URL.absoluteString;
    // *** 有缓存
    if([WFAsynHttpCacheManager isExistWithKey:[WFAsyncURLCache buildURLCacheKey:URLString]])
    {
        WFAsyncURLCacheData *cacheData = [WFAsynHttpCacheManager getWithKey:[WFAsyncURLCache buildURLCacheKey:URLString]];
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL
                                                            MIMEType:cacheData.textEncodingName
                                               expectedContentLength:cacheData.data.length
                                                    textEncodingName:cacheData.textEncodingName];
        NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:cacheData.data];
        return cachedResponse;
        
    }
    // *** 无缓存
    else
    {
        __block NSCachedURLResponse *cachedResponse = nil;
        id boolExsite = [self.responseDictionary objectForKey:URLString];
        if(!boolExsite) {
            [self.responseDictionary setValue:[NSNumber numberWithBool:YES] forKey:URLString];
            
            // *** 请求网络数据
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue new]
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if(!connectionError && response && data) {
                     
                     // *** 数据持久化
                    
                     WFAsyncURLCacheData *cacheData = [WFAsyncURLCacheData new];
                     cacheData.MIMEType = response.MIMEType;
                     cacheData.textEncodingName = response.textEncodingName;
                     cacheData.data = data;
                     [WFAsynHttpCacheManager saveWithData:cacheData andKey:[WFAsyncURLCache buildURLCacheKey:URLString]];
                     
                     cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                     
                 }
                 [self.responseDictionary removeObjectForKey:URLString];
                 
             }];
            
            return cachedResponse;
        }
        
    }
    return nil;
}

+ (BOOL)isWebFileRequest:(NSString *) URLString
{
    if([URLString rangeOfString:@".css"].length > 0 || [URLString rangeOfString:@".js"].length > 0)
    {
        return YES;
    }
    return NO;
}
+ (BOOL)checkURLCache:(NSString *)Key
{
    if([Key rangeOfString:@"WFAsyncURLCacheData_"].length > 0)
    {
        return YES;
    }
    return NO;
}
+ (NSString *)buildURLCacheKey:(NSString *)URLString
{
    return [NSString stringWithFormat:@"WFAsyncURLCacheData_%@",URLString];
}

@end
