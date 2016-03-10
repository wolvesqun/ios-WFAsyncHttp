//
//  ArticleBean.m
//  WFAsyncHttp
//
//  Created by mba on 16/3/10.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "ArticleBean.h"

@implementation ArticleBean

+ (id)beanWithDict:(NSDictionary *)dict
{
    id bean = [self objectWithKeyValues:dict];
    return bean;
}

@end
