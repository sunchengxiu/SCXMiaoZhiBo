//
//  UIView+Frame.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (UIView * (^)(CGFloat))X;
- (UIView * (^)(CGFloat))Y;
- (UIView * (^)(CGFloat))Width;
- (UIView * (^)(CGFloat))Height;
- (UIView * (^)(CGPoint))Center;
- (UIView * (^)(CGFloat))CenterX;
- (UIView * (^)(CGFloat))CenterY;
- (UIView * (^)(CGSize))Size;
- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;
- (CGSize)size;
- (CGFloat)centerX;
- (CGFloat)centerY;
@end
