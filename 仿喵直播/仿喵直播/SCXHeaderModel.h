//
//  SCXHeaderModel.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/25.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXHeaderResultModel.h"
@interface SCXHeaderModel : NSObject
/** 状态码 */
@property (nonatomic, copy) NSString *code;

/** 状态 */
@property (nonatomic, copy) NSString *msg;

/** 返回主播信息 */
@property (nonatomic, strong) NSArray *data;
@end
