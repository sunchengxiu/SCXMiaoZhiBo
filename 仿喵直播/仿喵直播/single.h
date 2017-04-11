//
//  single.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

// 单例
#define sharedToolH(name) + (instancetype)shared##name;
#define sharedToolM(name) static id sharedTool = nil;\
+(instancetype)shared##name{\
    \
    static dispatch_once_t onceToken;\
    \
    dispatch_once(&onceToken, ^{\
        sharedTool = [[self alloc]init];\
    });\
    \
    return sharedTool;\
\
}

