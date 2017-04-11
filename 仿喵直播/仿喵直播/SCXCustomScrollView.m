//
//  SCXCustomScrollView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXCustomScrollView.h"
#import "SCXHotViewController.h"
#import "SCXNewViewController.h"
#import "SCXAttentionViewController.h"
@implementation SCXCustomScrollView

-(void)setMainVC:(UIViewController *)mainVC{

    _mainVC = mainVC;
    
    [self basicSetUp];

}
- (void)basicSetUp{

    self.showsVerticalScrollIndicator = NO;
    
    self.showsHorizontalScrollIndicator = NO;
    
    self.bounces = NO;
    
    self.pagingEnabled = YES;
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.contentSize = CGSizeMake(ScreenW * 3, 0);
    
    SCXHotViewController *hot = [[SCXHotViewController alloc]init];
    hot.view.X(0);
    SCXNewViewController *new = [[SCXNewViewController alloc]init];
    new.view.X(ScreenW);
    SCXAttentionViewController *attention = [[SCXAttentionViewController alloc]init];
    attention.view.X(ScreenW * 2);
    [self addSubview:hot.view];
    [self addSubview:new.view];
    [self addSubview:attention.view];
    [self.mainVC addChildViewController:hot];
    [self.mainVC addChildViewController:new];
    [self.mainVC addChildViewController:attention];
    

}
@end
