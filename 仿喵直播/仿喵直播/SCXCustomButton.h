//
//  SCXCustomButton.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXCustomTitleView.h"
@interface SCXCustomButton : UIButton


/*************  填充颜色 ***************/
@property ( nonatomic , strong )UIColor *fillColor;

/*************  颜色进度 ***************/
@property ( nonatomic , assign )CGFloat progress;

#pragma mark - 创建按钮
+ (SCXCustomButton *)createBtnWithTile:(NSString *)title type:(NSInteger)tag superView:(UIView *)superView;
@end
