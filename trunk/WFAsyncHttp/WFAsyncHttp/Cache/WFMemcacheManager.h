//
//  WFMemcacheManager.h
//  WFAsyncHttp
//
//  Created by mba on 16/3/9.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  将数据保存到内存里
 *  注意，该内存使用的是key-value的方式，框架的key都是用请求地址作为key来保存到数据里，如果开发者要使用此类，那么必须确定key与框架使用的key不同
 */
@interface WFMemcacheManager : NSObject


/**
 *  将数据保存到内存里
 *  @param data 要保存的数据
 *  @param key  通过key保存到内存里，后面通过这个key来获取数据
 *  @param expiredTime  数据有效时间，单位为second（比如为60，表示60秒后如果数据还存在，那么将自动清除存在内存里的数据), 如果expiredTime<=0 那么就会永久保存到内存里，除非应用关闭才会被系统回收内存
 */
+ (void)addWithData:(id)data andKey:(NSString *)key andExpiredTime:(NSTimeInterval)expiredTime;


/**
 *  获取内存数据,判断是否有数据，也使用此方法（原因是先判断有数据，之后自动清除缓存，再取数据就为空了）
 */
+ (id)getCacheWithKey:(NSString *)key;


/**
 *  清除内存数据
 */
+ (void)clearWithKey:(NSString *)key;

@end
