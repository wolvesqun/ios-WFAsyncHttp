//
//  WFAsyncURLCache.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-13.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

/*** 图片MIMEType ***/
NSString *const kMIMETypeImgJPEG = @"image/jpeg";
NSString *const kMIMETypeImgGIF = @"image/gif";
NSString *const kMIMETypeImgPNG = @"image/png";
NSString *const kMIMETypeImgTIFF = @"image/tiff";
NSString *const KMIMETypeImgBMP = @"image/bmp";

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
        if([WFAsyncHttpUtil isWebFileRequest:URLString] || [WFAsyncHttpUtil isImageRequest:URLString])
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
    if([WFAsynHttpCacheManager isExistWithKey:[WFAsynHttpCacheManager buildURLCacheKey:URLString]])
    {
        id cacheData = [WFAsynHttpCacheManager getWithKey:[WFAsynHttpCacheManager buildURLCacheKey:URLString]];
        NSCachedURLResponse *cachedResponse;
        if([cacheData isKindOfClass:[NSData class]])
        {
            NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL
                                                                MIMEType:[self getMIMETypeImg:request]
                                                   expectedContentLength:((NSData *)cacheData).length
                                                        textEncodingName:nil];
            cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:cacheData];
        }
        else
        {
            NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL
                                                                MIMEType:((WFAsyncURLCacheData *)cacheData).MIMEType
                                                   expectedContentLength:((WFAsyncURLCacheData *)cacheData).data.length
                                                        textEncodingName:((WFAsyncURLCacheData *)cacheData).textEncodingName];
            cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:((WFAsyncURLCacheData *)cacheData).data];
        }
        
        
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
                     
                     if([WFAsyncHttpUtil isWebFileRequest:URLString])
                     {
                         WFAsyncURLCacheData *cacheData = [WFAsyncURLCacheData new];
                         cacheData.MIMEType = response.MIMEType;
                         cacheData.textEncodingName = response.textEncodingName;
                         cacheData.data = data;
                         [WFAsynHttpCacheManager saveWithData:cacheData andKey:[WFAsynHttpCacheManager buildURLCacheKey:URLString]];
                     }
                     else
                     {
                         [WFAsynHttpCacheManager saveWithData:data andKey:URLString];
                     }
                     
                     
                     cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                     
                 }
                 [self.responseDictionary removeObjectForKey:URLString];
                 
             }];
            
            return cachedResponse;
        }
        
    }
    return nil;
}

#pragma mark - 获取图片MIMEType
- (NSString *)getMIMETypeImg:(NSURLRequest *)request {
    NSRange pngRange = [[request URL].absoluteString rangeOfString:@".png"];
    if(pngRange.length > 0) return kMIMETypeImgPNG;
    
    NSRange gifRange = [[request URL].absoluteString rangeOfString:@".gif"];
    if(gifRange.length > 0) return kMIMETypeImgGIF;
    
    NSRange jpgRange = [[request URL].absoluteString rangeOfString:@".jpg"];
    NSRange jpegRange = [[request URL].absoluteString rangeOfString:@".jpeg"];
    if(jpgRange.length > 0 || jpegRange.length > 0) return kMIMETypeImgJPEG;
    
    NSRange bmpRange = [[request URL].absoluteString rangeOfString:@".bmp"];
    if(bmpRange.length > 0) return KMIMETypeImgBMP;
    
    return nil;
}


@end
