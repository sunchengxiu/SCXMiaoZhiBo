//
//  SCXNewData.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXNewData.h"

@implementation SCXNewData
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [SCXNewResultModel class]};

}
+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return  @{@"totalPage" : @"counts"};

}
@end
