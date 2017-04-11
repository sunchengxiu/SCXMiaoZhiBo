//
//  SCXPlayViewController.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXPlayViewController : UIViewController<LFLiveSessionDelegate>

/*************  直播展示底View ***************/
@property ( nonatomic , strong )UIView *preview;

/*************  直播会话 ***************/
@property ( nonatomic , strong )LFLiveSession *liveSession;

/*************  美颜按钮 ***************/
@property ( nonatomic , strong )UIButton *beautyBtn;

/*************  切换摄像头按钮 ***************/
@property ( nonatomic , strong )UIButton *switchCaptureBtn;

/*************  开始直播按钮 ***************/
@property ( nonatomic , strong )UIButton *beginBtn;

/*************  直播状态显示label ***************/
@property ( nonatomic , strong )UILabel *statuslabel;

/*************  关闭按钮 ***************/
@property ( nonatomic , strong )UIButton *closeBtn;

/*************  直播url ***************/
@property ( nonatomic , copy )NSString *rtmpUrl;
@end
