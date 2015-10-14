//
//  UIImageView+WFImageViewCache.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WFImageViewCache)

- (void)setImageWithKey:(NSString *)imgURL placeholderImage:(UIImage *)placeholderImage;

- (void)setImageWithKey:(NSString *)imgURL placeholderImage:(UIImage *)placeholderImage andSuccess:(void(^)(UIImage *image))success andFailure:(void(^)(NSError *error))failure;

- (void)removeCache:(NSString *)imgURL;

@end
