//
//  SCXNetWorkHelp.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXNewModel.h"
#import "SCXHeaderModel.h"
@interface SCXNetWorkHelp : NSObject
/**
 获取热门数据
 
 @param page 分页数
 @param success 成功block
 @param failure 失败block
 */
+ (void)SCX_GetHotDataWithPage:(NSInteger )page success:(void (^)(SCXNewModel *))success failure:(void (^)(NSError *))failure;

/*************  单例 ***************/
sharedToolH(NetTool);

/**
 用url来进行网络请求
 
 @param url url
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)SCX_GetUrlToConnentNetWork:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 获取广告

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)SCX_GetHeaderDataWithSuccess:(void (^)(SCXHeaderModel *))success failure:(void (^)(NSError *))failure;
@end
