//
//  SCXBaseController.m
//   
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseController.h"

@implementation SCXBaseController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=YES;
  
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}

#pragma mark -- 重写系统的一些有关控制器方法
/***推出一个控制器*/
-(void)SCX_PushViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    if (viewController.hidesBottomBarWhenPushed==NO) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [self.navigationController pushViewController:viewController animated:YES];

}
/**弹出一个控制器*/
-(void)SCX_PresentViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self presentViewController:viewController animated:YES completion:^{
        
    }];

}
/**回到一个控制器*/
-(void)SCX_PopViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**回到根控制器*/
-(void)SCX_PopToRootViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**回到指定的控制器*/
-(void)SCX_PopToViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popToViewController:viewController animated:YES];
    
}
/**销毁一个控制器*/
-(void)SCX_DismissViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
/**移除一个子控制器*/
-(void)SCX_RemoveChildViewController:(UIViewController *)viewController{
    if (viewController==nil) {
        return;
    }
    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];

    [viewController removeFromParentViewController];
}
/**添加一个子控制器*/
-(void)SCX_AddMydChildViewController:(UIViewController *)childViewController{

    if (childViewController==nil) {
        return;
    }
    [childViewController willMoveToParentViewController:self];
    [self.view addSubview:childViewController.view];
    childViewController.view.frame=self.view.bounds;
    [self addChildViewController:childViewController];
}

@end
