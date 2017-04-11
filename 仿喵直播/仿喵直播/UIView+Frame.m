//
//  UIView+Frame.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

/**
 设置X
 */
-(UIView *(^)(CGFloat))X{

    return ^ UIView * (CGFloat x){
    
        CGRect frame = self.frame;
        
        frame.origin.x = x;
        
        self.frame = frame;
        
        return self;
    };

}

/**
 设置Y
 */
-(UIView *(^)(CGFloat))Y{
    
    return ^ UIView * (CGFloat y){
        
        CGRect frame = self.frame;
        
        frame.origin.y = y;
        
        self.frame = frame;
        
        return self;
    };
    
}

/**
 设置宽度
 */
-(UIView *(^)(CGFloat))Width{
    
    return ^ UIView * (CGFloat width){
        
        CGRect frame = self.frame;
        
        frame.size.width = width;
        
        self.frame = frame;
        
        return self;
    };
    
}

/**
 设置宽度
 */
-(UIView *(^)(CGFloat))Height{
    
    return ^ UIView * (CGFloat height){
        
        CGRect frame = self.frame;
        
        frame.size.height = height;
        
        self.frame = frame;
        
        return self;
    };
    
}

/**
 设置center
 */
-(UIView *(^)(CGPoint))Center{
    
    return ^ UIView * (CGPoint center){
        
        CGPoint centerOrigin = self.center;
        
        centerOrigin = center;
        
        self.center = centerOrigin;
        
        return self;
    };
    
}

/**
 设置centerX
 */
-(UIView *(^)(CGFloat))CenterX{
    
    return ^ UIView * (CGFloat centerX){
        
        CGPoint center = self.center;
        
        center.x = centerX;
        
        self.center = center;
        
        return self;
    };
    
}

/**
 设置centerX
 */
-(UIView *(^)(CGFloat))CenterY{
    
    return ^ UIView * (CGFloat centerY){
        
        CGPoint center = self.center;
        
        center.y = centerY;
        
        self.center = center;
        
        return self;
    };
    
}

/**
 设置Size
 */
- (UIView *(^)(CGSize))Size
{
    return ^UIView*(CGSize size){
        
        CGRect frame = self.frame;
        
        frame.size = size;
        
        self.frame = frame;
        
        return self;
    };
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

/**
 X

 @return X
 */
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/**
 Y

 @return Y
 */
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/**
 宽度

 @return 宽度
 */
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

/**
 高度

 @return 高度
 */
- (CGFloat)height
{
    return self.frame.size.height;
}

/**
 size

 @return size
 */
- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/**
 CenterX

 @return CenterX
 */
- (CGFloat)centerX{
    return self.frame.origin.x;
    
}

- (void)setCenterX:(CGFloat)centerX{
    CGRect frame = self.frame;
    frame.origin.x = centerX;
    self.frame = frame;
}

/**
 centerY

 @return centerY
 */
- (CGFloat)centerY{
    return self.frame.origin.y;
}

- (void)setCenterY:(CGFloat)centerY{
    CGRect frame = self.frame;
    frame.origin.y = centerY;
    self.frame = frame;
}


@end
