//
//  UIImageView+WFImageViewCache.h
//  WFAsyncHttp
//
//  Created by mba on 15-10-14.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WFImageViewCache)

/**
 *  request image
 *
 *  @param imageURL : request image error
 *  @param placeholderImage : set image beform request image
 */
- (void)setImageWithKey:(NSString *)imgURL placeholderImage:(UIImage *)placeholderImage;

/**
 *  request image
 *
 *  @param imageURL : request image error
 *  @param placeholderImage : set image beform request image
 *  @param success : request success
 *  @param failure : request error
 */
- (void)setImageWithKey:(NSString *)imgURL placeholderImage:(UIImage *)placeholderImage andSuccess:(void(^)(UIImage *image))success andFailure:(void(^)(NSError *error))failure;

/**
 *  remove img cache
 */
- (void)removeCache:(NSString *)imgURL;

@end
