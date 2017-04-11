//
//  SCXWatchLiveTopView.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXNewResultModel.h"
@interface SCXWatchLiveTopView : UIView

/*************  头部试图 ***************/
@property ( nonatomic , strong )UIView *topView;

/*************  头像 ***************/
@property ( nonatomic , strong )UIImageView *iconimageView;

/*************  名字label ***************/
@property ( nonatomic , strong )UILabel *nameLabel;

/*************  在线观看人数label ***************/
@property ( nonatomic , strong )UILabel *peopleCountLabel;

/*************  房间号label ***************/
@property ( nonatomic , strong )UILabel *roomIDLable;

/*************  展示猫粮的GIFView ***************/
@property ( nonatomic , strong )UIButton *GIFBtn;

/*************  关注button ***************/
@property ( nonatomic , strong )UIButton *careBtn;

/*************  其他主播scrollView ***************/
@property ( nonatomic , strong )UIScrollView *otherLiveScrollView;

/*************  监听人数定时器 ***************/
@property ( nonatomic , strong )NSTimer *timer;

@property (nonatomic, copy) void (^selectBlock)(SCXNewResultModel *hotModel, UIImage *image);


/*************  主播数据模型 ***************/
@property ( nonatomic , strong )SCXNewResultModel *model;

/*************  全部主播模型 ***************/
@property ( nonatomic , strong )NSMutableArray *allModels;

- (void)beginAnimation;


@end
