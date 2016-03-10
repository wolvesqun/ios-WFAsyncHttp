//
//  ArticleBean.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/10.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJKeyValue.h"

@interface ArticleBean : NSObject

//@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *content;

+ (id)beanWithDict:(NSDictionary *)dict;

@end
