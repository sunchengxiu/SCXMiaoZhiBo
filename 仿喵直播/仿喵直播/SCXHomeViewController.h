//
//  SCXHomeViewController.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/3.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXCustomTitleView.h"
#import "SCXCustomScrollView.h"
#import "SCXBaseController.h"
@interface SCXHomeViewController : SCXBaseController

/*************  自定义头部试图 ***************/
@property ( nonatomic , strong )SCXCustomTitleView *titleView;

/*************  自定义主ScrollView ***************/
@property ( nonatomic , strong )SCXCustomScrollView *scrollView;

@end
