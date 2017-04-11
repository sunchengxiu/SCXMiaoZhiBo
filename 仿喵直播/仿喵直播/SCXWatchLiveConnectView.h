//
//  SCXWatchLiveConnectView.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXNewResultModel.h"
@interface SCXWatchLiveConnectView : UIView

/*************  播放器，只播放视频  不播放声音 ***************/
@property ( nonatomic , strong )IJKFFMoviePlayerController *moivePlayer;

/*************  主播模型 ***************/
@property ( nonatomic , strong )SCXNewResultModel *model;

/*************  点击其他主播block ***************/
@property ( nonatomic , strong )void (^selectOtherBlock)(SCXNewResultModel *model);

/**
 将小窗口移除
 */
- (void)removeOtherLiveView;
@end
