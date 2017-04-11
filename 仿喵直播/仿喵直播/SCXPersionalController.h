//
//  SCXPersionalController.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseTableViewController.h"
#import "SCXOtherViewController.h"
#import "SCXTableHeaderView.h"
@interface SCXPersionalController :SCXBaseTableViewController

/*************  分区数组 ***************/
@property ( nonatomic , strong )NSArray *dataList;

/*************  头部试图 ***************/
@property ( nonatomic , strong )SCXTableHeaderView *headerView;
@end
