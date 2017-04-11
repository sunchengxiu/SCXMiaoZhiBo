//
//  SCXLoginController.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/3.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXLoginController.h"
#import "SCXTabBarController.h"
@interface SCXLoginController ()


/*************  登陆按钮 ***************/
@property ( nonatomic , strong )UIButton *loginButton;

/*************  coverView ***************/
@property ( nonatomic , strong )UIView *coverView;

/*************  ijkMediaPlayer ***************/
@property ( nonatomic , strong )IJKFFMoviePlayerController *ijkPlayer;

/*************  hud ***************/
@property ( nonatomic , strong )MBProgressHUD *hud;

@end

@implementation SCXLoginController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 登陆界面没出现视频之前的覆盖图片，和启动图保持一致
    [self coverView];
    
    // 登陆按钮
    [self loginButton];
    
    // 监听ijkMediaPlayer
    [self moniorIJKMediaPlayerState];
    //[self loginOK];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.ijkPlayer play];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.ijkPlayer pause];
    
}
#pragma mark - 监听ijkMediaPlayer
- (void)moniorIJKMediaPlayerState{
    
    // 播放完成监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // 播放状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}
#pragma mark - ijkmediaplayer状态监听结果
- (void)didFinish{
    [self.ijkPlayer play];
}
- (void)didChange{
    if ((self.ijkPlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        [self.ijkPlayer play];
        [self.view insertSubview:self.coverView atIndex:0];
    }
}
#pragma mark - 懒加载
-(UIButton *)loginButton{
    
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]init];
        _loginButton.backgroundColor = [UIColor clearColor];
        _loginButton.titleColor = BasicColor;
        _loginButton.title = @"快速登录";
        _loginButton.layer.borderWidth = 1;
        _loginButton.layer.borderColor = BasicColor.CGColor;
        _loginButton.highlightedTitleColor = [UIColor redColor];
        
        [_loginButton addTarget:self action:@selector(loginClick)];
        
        [self.view addSubview:_loginButton];
        
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@-40);
            make.centerX.mas_equalTo(ScreenW * 0.5);
            make.height.equalTo(@40);
            make.bottom.equalTo(self.view).offset(-60);
        }];
        
    }
    return _loginButton;
}

-(UIView *)coverView{

    if (_coverView == nil) {
        UIImageView *cover = [[UIImageView alloc] initWithFrame:self.view.bounds];
        cover.image = [UIImage imageNamed:@"LaunchImage"];
        [self.ijkPlayer.view addSubview:cover];
        _coverView = cover;
    }
    return _coverView;
}
-(IJKFFMoviePlayerController *)ijkPlayer{

    if (!_ijkPlayer) {
        NSString *path = arc4random_uniform(2) ? @"login_video" : @"loginmovie";
//        NSString *videoPath = [[NSBundle mainBundle] pathForResource:path ofType:@"mp4"];
        NSString *videoPath = @"";
        _ijkPlayer = [[IJKFFMoviePlayerController alloc]initWithContentURLString:videoPath withOptions:[IJKFFOptions optionsByDefault]];
        _ijkPlayer.view.frame = self.view.frame;
        _ijkPlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
        _ijkPlayer.shouldAutoplay = NO;
        [_ijkPlayer prepareToPlay];
        [self.view addSubview:_ijkPlayer.view];
    }
    return _ijkPlayer;

}
#pragma mark -------------------- 按钮点击事件 -------------------------
- (void)loginClick{
    _hud = [MBProgressHUD showMessage:@"登录中..."];
    [self loginOK];
}
- (void)loginOK{
        SCXTabBarController *tabbar = [[SCXTabBarController alloc]init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_hud hideAnimated:YES];
        [MBProgressHUD showSuccess:@"登陆成功"];
        [self presentViewController:tabbar animated:YES completion:^{
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self.ijkPlayer pause];
            [self.ijkPlayer stop];
            [self.ijkPlayer shutdown];
            [self.ijkPlayer.view removeFromSuperview];
            self.ijkPlayer = nil;
        }];
        
    });
    
}
@end
