//
//  SCXNewModel.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCXNewModel : NSObject
/** 状态码 */
@property (nonatomic, copy) NSString *code;

/** 状态 */
@property (nonatomic, copy) NSString *msg;

/** 返回主播信息 */
@property (nonatomic, strong) NSDictionary *data;
@end
