//
//  SCXNewData.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXNewResultModel.h"
@interface SCXNewData : NSObject
/** 返回多少条主播信息 */
@property (nonatomic, strong) NSNumber *totalPage;
/** 主播信息列表 */
@property (nonatomic, strong) NSArray *list;
@end
