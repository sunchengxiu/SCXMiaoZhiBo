//
//  SCXHeaderModel.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/25.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXHeaderModel.h"

@implementation SCXHeaderModel
+(NSDictionary *)mj_objectClassInArray{

    return @{@"data" : [SCXHeaderResultModel class]};
}
@end
