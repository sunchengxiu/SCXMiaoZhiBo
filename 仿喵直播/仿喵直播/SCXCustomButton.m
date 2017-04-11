//
//  SCXCustomButton.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXCustomButton.h"

@implementation SCXCustomButton
#pragma mark - 创建按钮
+ (SCXCustomButton *)createBtnWithTile:(NSString *)title type:(NSInteger)tag superView:(UIView *)superView{
    
    SCXCustomButton *btn = ({
        SCXCustomButton *btn = [[SCXCustomButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        btn.textColor = [UIColor whiteColor];
//        btn.text = title;
        btn.tag = tag ;
        [btn sizeToFit];
        CGFloat margin = (superView.width - btn.width * 3) / 2;
        btn.frame = CGRectMake((margin + btn.width) * tag, 0, btn.width, btn.height);
        btn;
    });
      [superView addSubview:btn];
    return btn;
}


@end
