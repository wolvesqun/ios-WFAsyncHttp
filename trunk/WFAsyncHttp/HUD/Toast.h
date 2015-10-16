//
//  Toast.h
//  wiki
//
//  Created by mba on 14-5-30.
//  Copyright (c) 2014年 mbalib. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  显示框
 */
@interface Toast : NSObject


/**
 *  菊花加载中提示
 */
+ (void)showActivityIndicatorView;

/**
 *  菊花加载中提示停止动画
 */
+ (void)dimissActivityIndicatorView;

/**
 *  强制停止菊花动画
 */
+ (void)dimissActivityIndicatorViewByMandatory;



@end
