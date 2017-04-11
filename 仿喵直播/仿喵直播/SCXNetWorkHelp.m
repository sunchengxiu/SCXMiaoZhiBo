//
//  SCXNetWorkHelp.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXNetWorkHelp.h"

@implementation SCXNetWorkHelp

/*************  单例 ***************/
sharedToolM(NetTool);

/**
 获取热门数据

 @param page 分页数
 @param success 成功block
 @param failure 失败block
 */
+ (void)SCX_GetHotDataWithPage:(NSInteger )page success:(void (^)(SCXNewModel *))success failure:(void (^)(NSError *))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    manager.requestSerializer.HTTPShouldHandleCookies = NO;
    manager.requestSerializer.HTTPShouldUsePipelining = YES;
    [manager.operationQueue cancelAllOperations];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    NSString *url = [NSString stringWithFormat:@"%@=%ld",SCXHotFileAPI,page];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        SCXNewModel *model = [SCXNewModel mj_objectWithKeyValues:responseObject];
        
        success(model);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    

}

/**
用url来进行网络请求

 @param url url
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)SCX_GetUrlToConnentNetWork:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}
+ (void)SCX_GetHeaderDataWithSuccess:(void (^)(SCXHeaderModel *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [manager GET:@"http://live.9158.com/Living/GetAD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        SCXHeaderModel *result = [SCXHeaderModel mj_objectWithKeyValues:responseObject];
        
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}
@end
