//
//  SCXWatchLIveEndView.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXWatchLIveEndView : UIView

/*************  线 ***************/
@property ( nonatomic , strong )UIView *oneLine;

/*************  线 ***************/
@property ( nonatomic , strong )UIView *twoLine;

/*************  结束标签 ***************/
@property ( nonatomic , strong )UILabel *endLabel;

/*************  直播时长 ***************/
@property ( nonatomic , strong )UILabel *timeLabel;

/*************  结束标签 ***************/
@property ( nonatomic , strong )UILabel *endTimeLabel;

/*************  人数标签 ***************/
@property ( nonatomic , strong )UILabel *countLabel;

/*************  人数标签 ***************/
@property ( nonatomic , strong )UILabel *countNameLabel;

/*************  关注按钮 ***************/
@property ( nonatomic , strong )UIButton *careBtn;

/*************  查看其他主播标签 ***************/
@property ( nonatomic , strong )UIButton *otherBtn;

/*************  推出按钮 ***************/
@property ( nonatomic , strong )UIButton *quitBtn;

/*************  背景图 ***************/
@property ( nonatomic , strong )UIImageView *backImageView;

/** 查看其他主播 */
@property (nonatomic, copy) void (^lookOtherBlock)();
/** 退出 */
@property (nonatomic, copy) void (^quitBlock)();

@end
