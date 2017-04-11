//
//  SCXWatchLiveViewController.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXBaseController.h"
#import "SCXNewResultModel.h"
#import "SCXWatchLIveEndView.h"
#import "SCXWatchLiveTopView.h"
#import "SCXWatchLiveInfoView.h"
#import "SCXWatchLiveBottomView.h"
#import "SCXWatchLiveOtherLiveView.h"
#import "SCXWatchLiveConnectView.h"
#import "SCXWatchLiveOtherLiveView.h"
@interface SCXWatchLiveViewController : SCXBaseController

/*************  直播模型 ***************/
@property ( nonatomic , strong )SCXNewResultModel *model;

/*************  直播播放器 ***************/
@property ( nonatomic , strong )IJKFFMoviePlayerController *livePlayer;

/*************  头部试图 ***************/
@property ( nonatomic , strong )SCXWatchLiveTopView *topView;

/*************  底部试图 ***************/
@property ( nonatomic , strong )SCXWatchLiveBottomView *bottomView;

/*************  结束试图 ***************/
@property ( nonatomic , strong )SCXWatchLIveEndView *endView;

/*************  infoView ***************/
@property ( nonatomic , strong )SCXWatchLiveInfoView *infoView;

/*************  其他主播试图 ***************/
@property ( nonatomic , strong )SCXWatchLiveOtherLiveView *otherLiveView;

/*************  连麦试图 ***************/
@property ( nonatomic , strong )SCXWatchLiveConnectView *connectView;

/*************  GIFLoadingView ***************/
@property ( nonatomic , strong )UIImageView *gifView;

/*************  底图 ***************/
@property ( nonatomic , strong )UIImageView *placeHolderView;

/*************  弹幕 ***************/
@property ( nonatomic , strong )BarrageRenderer *renderer;

/*************  弹幕数组 ***************/
@property ( nonatomic , strong )NSMutableArray *rendererTextArr;

/*************  粒子动画 ***************/
@property ( nonatomic , strong )CAEmitterLayer *emitterLayer;

/*************  全部主播模型 ***************/
@property ( nonatomic , strong )NSMutableArray *allModels;

@end
