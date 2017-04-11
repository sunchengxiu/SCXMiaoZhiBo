//
//  SCXTabBarController.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/3.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXTabBarController.h"
#import "SCXHomeViewController.h"
#import "SCXLiveViewController.h"
#import "SCXPersionalController.h"
#import "SCXBasicNavigationController.h"
#import "SCXPlayViewController.h"
@interface SCXTabBarController ()<UITabBarControllerDelegate>

@end

@implementation SCXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加子控制器到tabbar上面
    [self addChildController];
    
}
- (void)addChildController{

    [self addChildViewController:[SCXHomeViewController new] selectImage:@"toolbar_home_sel" normalImageName:@"toolbar_home" title:@"首页" titleColor:BasicColor];
    
    [self addChildViewController:[SCXLiveViewController new] selectImage:nil normalImageName:@"toolbar_live" title:@"直播" titleColor:BasicColor];
    
    [self addChildViewController:[SCXPersionalController new] selectImage:@"toolbar_me_sel" normalImageName:@"toolbar_me" title:@"个人中心" titleColor:BasicColor];
}

- (void)addChildViewController:(UIViewController *)childController selectImage:(NSString *)selectImageName normalImageName:(NSString *)normalImageName title:(NSString *)title titleColor:(UIColor *)titleColor{

    SCXBasicNavigationController *basicNav = [[SCXBasicNavigationController alloc]initWithRootViewController:childController];
    
    childController.title = title;
    
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    
    childController.tabBarItem.image = [UIImage imageNamed:normalImageName];
    
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : titleColor} forState:UIControlStateNormal];
    
    [self addChildViewController:basicNav];


}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    if ([viewController.tabBarItem.image isEqual:[UIImage imageNamed:@"toolbar_live"]]){

        [self presentViewController:[SCXPlayViewController new] animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}


@end
