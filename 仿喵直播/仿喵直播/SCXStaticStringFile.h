//
//  SCXStaticStringFile.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SCXStaticStringFile : NSObject
#ifdef __cplusplus
#define SCXKIT_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define SCXKIT_EXTERN	        extern __attribute__((visibility ("default")))
#endif

/*************  热门API ***************/
SCXKIT_EXTERN NSString *const SCXHotFileAPI;
@end
