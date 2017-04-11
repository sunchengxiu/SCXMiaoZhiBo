//
//  SCXBaseController.h
//   
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXBaseController : UIViewController

/**添加一个子控制器*/
-(void)SCX_AddMydChildViewController:(UIViewController *)childViewController;

/**移除一个子控制器*/
-(void)SCX_RemoveChildViewController:(UIViewController *)viewController;

/**销毁一个控制器*/
-(void)SCX_DismissViewController:(UIViewController *)viewController;

/**回到指定的控制器*/
-(void)SCX_PopToViewController:(UIViewController *)viewController;

/**回到根控制器*/
-(void)SCX_PopToRootViewController:(UIViewController *)viewController;

/**回到一个控制器*/
-(void)SCX_PopViewController:(UIViewController *)viewController;

/**弹出一个控制器*/
-(void)SCX_PresentViewController:(UIViewController *)viewController;

/***推出一个控制器*/
-(void)SCX_PushViewController:(UIViewController *)viewController;

@end
