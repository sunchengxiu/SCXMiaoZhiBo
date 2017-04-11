//
//  SCXTableHeaderView.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXTableHeaderView : UIImageView
/**
 初始化
 
 @param frame 头部试图尺寸
 @param backgroundImageName 背景图
 @param iconImageName 头像
 @param title 标题
 */
- (instancetype)initWithFrame:(CGRect)frame backgroundImageName:(NSString *)backgroundImageName iconImageName:(NSString *)iconImageName titleName:(NSString *)title;

/**
 开始震动
 */
- (void)startWave;
/**
 停止震动
 */
- (void)stopWave;

@end
