//
//  UIImageView+WFImageViewCache.m
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "UIImageView+WFImageViewCache.h"
#import "WFAsyncHttpClient.h"
#import "WFAsyncHttpCacheManager.h"

@implementation UIImageView (WFImageViewCache)

- (void)setImageWithKey:(NSString *)imgURL placeholderImage:(UIImage *)placeholderImage
{
    [self setImageWithKey:imgURL placeholderImage:placeholderImage andSuccess:nil andFailure:nil];
}

- (void)setImageWithKey:(NSString *)imgURL
       placeholderImage:(UIImage *)placeholderImage
             andSuccess:(void (^)(UIImage *))success
             andFailure:(void (^)(NSError *))failure
{
    if(placeholderImage != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = placeholderImage;
        });
    }
    
    [WFAsyncHttpClient System_GET_WithURLString:imgURL
                                     andHeaders:nil
                                 andCachePolicy:WFAsyncCachePolicyType_ReturnCache_DontLoad
                                     andSuccess:^(id responseObject)
     {
         UIImage *img = [[UIImage alloc] initWithData:responseObject];
         dispatch_async(dispatch_get_main_queue(), ^{
             self.image = img;
         });
         
         if(success) success(img);
     } andFailure:^(NSError *error) {
         if(failure) failure(error);
     }];
}

- (void)removeCache:(NSString *)imgURL
{
    [WFAsyncHttpCacheManager removeWithKey:imgURL];
}

@end
