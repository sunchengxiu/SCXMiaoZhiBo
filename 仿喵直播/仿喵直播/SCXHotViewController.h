//
//  SCXHotViewController.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/3.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseTableViewController.h"
#import "SCXBaseTableViewCell.h"
#import "SCXHotCell.h"
#import "SCXNewData.h"
#import "SCXWatchLiveViewController.h"
@interface SCXHotViewController : SCXBaseTableViewController



/*************  分页 ***************/
@property ( nonatomic , assign )NSInteger page;

/*************  热门数据 ***************/
@property ( nonatomic , strong )SCXNewData *data;

@end
