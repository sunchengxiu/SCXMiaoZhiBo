//
//  SCXPlayViewController.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXPlayViewController.h"

@interface SCXPlayViewController ()

@end

@implementation SCXPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self preview];
    [self configViews];
    self.liveSession.captureDevicePosition = AVCaptureDevicePositionFront;
}
#pragma mark -------------- 懒加载 -----------------
-(UIView *)preview{

    if (!_preview) {
        _preview = [[UIView alloc]initWithFrame:self.view.bounds];
        _preview.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_preview];
    }
    return _preview;
}
-(LFLiveSession *)liveSession{

    if (!_liveSession) {
        _liveSession = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
        _liveSession.delegate = self;
        _liveSession.running = YES;
        _liveSession.preView = self.preview;
    }
    return _liveSession;
}
- (void)configViews{

    [self.beautyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.preview.mas_top).offset(34);
        make.left.mas_equalTo(self.preview.mas_left).offset(30);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(200);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beautyBtn.mas_top).offset(10);
        make.right.mas_equalTo(self.preview.mas_right).offset(-30);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        
    }];
    [self.switchCaptureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beautyBtn.mas_top).offset(10);
        make.right.mas_equalTo(self.preview.mas_right).offset(-70);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        
    }];
    [self.statuslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.switchCaptureBtn.mas_bottom).offset(50);
        make.right.mas_equalTo(self.preview.mas_right).offset(-30);
        make.height.mas_equalTo(50);
        
    }];
    [self.beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.preview.mas_centerX);
        make.bottom.mas_equalTo(self.preview.mas_bottom).offset(-70);
        make.width.mas_equalTo(200);
    }];
    

}
-(UIButton *)beautyBtn{

    if (!_beautyBtn) {
        _beautyBtn = [[UIButton alloc]init];
        [_beautyBtn setTitle:@"美颜功能已开启" forState:UIControlStateNormal];
        [_beautyBtn setTitle:@"美颜功能已关闭" forState:UIControlStateSelected];
        [_beautyBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_beautyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_beautyBtn setImage:[UIImage imageNamed:@"icon_beautifulface_19x19"] forState:UIControlStateNormal];
        [_beautyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 5)];
        _beautyBtn.layer.cornerRadius = 10;
        [_beautyBtn setBackgroundColor:BasicLightGrayColor];
        [_beautyBtn addTarget: self action:@selector(beautyHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.preview addSubview:_beautyBtn];
    }
    return _beautyBtn;

}
-(UIButton *)beginBtn{
    
    if (!_beginBtn) {
        _beginBtn = [[UIButton alloc]init];
        [_beginBtn setTitle:@"开始直播" forState:UIControlStateNormal];
        [_beginBtn setTitle:@"结束直播" forState:UIControlStateSelected];
        [_beginBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _beginBtn.layer.cornerRadius = 10;
        [_beginBtn setBackgroundColor:BasicLightGrayColor];
        [_beginBtn addTarget: self action:@selector(beginLiveHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.preview addSubview:_beginBtn];
    }
    return _beginBtn;
    
}
-(UIButton *)switchCaptureBtn{
    
    if (!_switchCaptureBtn) {
        _switchCaptureBtn = [[UIButton alloc]init];
        [_switchCaptureBtn setImage:[UIImage imageNamed:@"camera_change_40x40"] forState:UIControlStateNormal];
        [_switchCaptureBtn addTarget: self action:@selector(switchCaptureHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.preview addSubview:_switchCaptureBtn];
    }
    return _switchCaptureBtn;
    
}
-(UILabel *)statuslabel{

    if (!_statuslabel) {
        _statuslabel = [[UILabel alloc] init];
        _statuslabel.text = @"状态";
        _statuslabel.textColor = [UIColor redColor];
       // _statuslabel.backgroundColor = BasicLightGrayColor;
        [self.preview addSubview:_statuslabel];
    }
    return _statuslabel;
}
-(UIButton *)closeBtn{

    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        [_closeBtn setImage:[UIImage imageNamed:@"user_close_15x15"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.preview addSubview:_closeBtn];
    }
    return _closeBtn;

}
#pragma mark -------------- 点击事件处理 -----------------
- (void)close{

    if (self.liveSession.state == LFLiveStart || self.liveSession.state == LFLivePending) {
        [self.liveSession stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
/**
 美颜处理
 */
- (void)beautyHandle:(UIButton *)btn{
    if (![self isAvaliableOrAuthorizationStatus]) {
        return;
    }
    self.beautyBtn.selected = !self.beautyBtn.selected;
    if (self.beautyBtn.selected) {
        self.liveSession.beautyFace = NO;
        NSLog(@"美颜功能关闭");
    }
    else{
        self.liveSession.beautyFace = YES;
        NSLog(@"美颜功能开启");
    }
}

/**
 切换摄像头处理

 */
- (void)switchCaptureHandle:(UIButton *)btn{
    if (![self isAvaliableOrAuthorizationStatus]) {
        return;
    }
    self.switchCaptureBtn.selected = !self.switchCaptureBtn.selected;
    if (self.switchCaptureBtn.selected) {
        NSLog(@"开启后摄像头");
        self.liveSession.captureDevicePosition = AVCaptureDevicePositionBack;
    }
    else{
        self.liveSession.captureDevicePosition = AVCaptureDevicePositionFront;
        NSLog(@"开始前置摄像头了");
    }
}

/**
 开始直播处理

 */
- (void)beginLiveHandle:(UIButton *)btn{
    if (![self isAvaliableOrAuthorizationStatus]) {
        return;
    }
    self.beginBtn.selected= !self.beginBtn.selected;
    if (self.beginBtn.selected) {
        
        LFLiveStreamInfo *info = [[LFLiveStreamInfo alloc]init];
        info.url = @"rtmp://10.10.10.100:1935/rtmplive/room";
        self.rtmpUrl = info.url;
        [self.liveSession startLive:info];
        NSLog(@"开始直播");
        
    }
    else{
        NSLog(@"结束直播了");
        if (self.liveSession.state == LFLivePending || self.liveSession.state == LFLiveStart) {
            [self.liveSession stopLive];
            
        }
        self.statuslabel.text = @"状态：直播关闭";
    }
}
#pragma mark -------------- 判断是否有权限 -----------------
- (BOOL)isAvaliableOrAuthorizationStatus{

    // 先判断是不是模拟器
    if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
        [MBProgressHUD showAlertMessage:@"当前不支持模拟器，请用真机测试"];
        return NO;
    }
    
    // 判断是都有摄像头
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [MBProgressHUD showAlertMessage:@"您的设备没有摄像头或者驱动，无法进行直播"];
        return NO;
    }
    
    // 判断是否有相机权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        [MBProgressHUD showAlertMessage:@"您没有相机权限哦，请到设置中打开"];
        return NO;
    }
    
    // 判断是否打开麦克风
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL permission){
            if (permission) {
                return YES;
            }
            else{
                [MBProgressHUD showAlertMessage:@"APP无法的访问麦克风"];
                return NO;
            }
        }];
    }
    return YES;

}
#pragma mark -------------- 直播代理方法 -----------------
-(void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state{

    NSString *status = @"";
    switch (state) {
        case LFLiveReady:
            status = @"准备中";
            break;
            case LFLiveStop:
            status = @"已断开";
            break;
            case LFLiveError:
            status = @"连接出错";
            break;
            case LFLiveStart:
            status = @"已连接";
            break;
            case LFLivePending:
            status = @"连接中";
            break;
            case LFLiveRefresh:
            status = @"正在刷新";
            break;
        default:
            break;
    }
    self.statuslabel.text = [NSString stringWithFormat:@"状态：%@",status];

}
@end
