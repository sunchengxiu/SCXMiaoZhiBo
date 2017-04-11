//
//  SCXUtil.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SCXRefreshUpOfDownBlock)();
@interface SCXUtil : NSObject

/**
 普通下拉刷新
 
 @param block 下拉刷新回调
 */
+(void)SCX_addDownRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block;

/**
 普通上拉刷新
 
 @param block 上啦刷新回调
 */
+(void)SCX_addUpRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block;

/**
 GIF下拉刷新
 
 @param block GIF下拉刷新回调
 */
+(void)SCX_addDownGIFRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block;
@end
