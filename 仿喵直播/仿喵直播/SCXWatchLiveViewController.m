//
//  SCXWatchLiveViewController.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXWatchLiveViewController.h"

@interface SCXWatchLiveViewController ()

@end

@implementation SCXWatchLiveViewController
-(instancetype)init{

    if (self = [super init]) {
        [self configView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

}
- (void)configView{

    // 添加地图
    [self placeHolderView];
    
    // 添加头部试图
    [self topView];
    
    // 添加底部试图
    [self bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-10);
        make.height.equalTo(@40);
    }];
    
    // 创建粒子弹射动画
    [self emitterLayer];
    
    
    // 弹幕
    [ self renderer];
   // [self sendRenderer];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(sendRenderer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
   
    
}
#pragma mark -------------- 入口，逻辑处理 -----------------
-(void)setModel:(SCXNewResultModel *)model{
    
    _model = model;
    self.topView.model = model;
    self.topView.allModels = self.allModels;
    // 开始观看直播
    [self beginWatchLiveWithLiveUrl:model.flv placeholderImageUrl:model.bigpic];
    
    // 给其他推荐主播模型
    NSInteger i = arc4random_uniform((int)self.allModels.count);
    self.connectView.model = self.allModels[i];
    
}

#pragma mark -------------- 懒加载 -----------------
- (UIImageView *)placeHolderView
{
    if (_placeHolderView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.view.bounds;
        
        imageView.image = [UIImage imageNamed:@"profile_user_414x414"];
        
        [self.view addSubview:imageView];
        
        _placeHolderView = imageView;
        [_placeHolderView layoutIfNeeded];
        
    }
    return _placeHolderView;
}
-(SCXWatchLiveTopView *)topView{
    if (!_topView) {
        _topView = [[SCXWatchLiveTopView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 60+30+10+60+10)];
        [_topView setBackgroundColor:[UIColor clearColor]];
        [self.view insertSubview:_topView aboveSubview:self.placeHolderView];
    }
    return _topView;
}
-(SCXWatchLiveBottomView *)bottomView{

    if (!_bottomView) {
        _bottomView = [[SCXWatchLiveBottomView alloc]init];
        
        __weak typeof(self)weakSelf = self;
        [_bottomView setClickToolBlock:^(NSInteger tag) {
            switch (tag) {
                case 0:
                {
                
                }
                    break;
                case 1:{
                
                }
                    break;
                    case 2:
                {
                
                }
                    break;
                case 3:{
                
                }
                    break;
                case 4:{
                
                }
                    break;
                case 5:{
                    [self quit];
                }
                    break;
                default:
                    break;
            }
            
        }];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}
-(UIImageView *)gifView{

    if (!_gifView) {
        
        NSArray *  images = @[[UIImage imageNamed:@"hold1_60x72"], [UIImage imageNamed:@"hold2_60x72"], [UIImage imageNamed:@"hold3_60x72"]];
      
        UIImageView *gifView = [[UIImageView alloc] init];
        
       
        _gifView = gifView;
        _gifView.animationImages = images;
        _gifView.animationDuration = 0.5;
        _gifView.animationRepeatCount = 0;
    }
    return _gifView;

}
-(CAEmitterLayer *)emitterLayer{

    if (!_emitterLayer) {
        
        // 创建发射器
        _emitterLayer = [CAEmitterLayer layer];
        
        // 发射器的发射位置
        _emitterLayer.emitterPosition = CGPointMake(self.view.width - 50, self.view.height - 100);
        
        // 渲染模式
        _emitterLayer.renderMode = kCAEmitterLayerUnordered;
        
        // 发射器尺寸
        _emitterLayer.emitterSize = CGSizeMake(50, 50);
        
        // 创建发射器子弹
        NSMutableArray *arr  = [NSMutableArray array];
        for (NSInteger i = 0; i < 10 ; i ++) {
            // 创建子弹
            CAEmitterCell *cell = [CAEmitterCell emitterCell];
            
            // 粒子参数的速度乘数因子，值越大，界面上现实的越多越浓密
            cell.birthRate = 2;
            
            // 粒子生命存活时间，时间越长，显示的越持久
            cell.lifetime = arc4random_uniform(4) + 1;
            // 粒子生存时间容差
            cell.lifetimeRange = 2;
            
            // 粒子的速度
            cell.velocity = arc4random_uniform(100) + 150;
            cell.velocityRange = 150;
            
            // 粒子的发射角度，水平面上
            cell.emissionLongitude = M_PI + M_PI_2;
            // 让他产生一个弧度或者圆形的样子发射出去
            cell.emissionRange = M_PI_2 / 6;
            
            // 粒子的缩放比例
            cell.scale = 0.3;
            
            // 创建粒子单位
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%ld_30x30",i]];
            cell.contents = (id)[image CGImage];
            [arr addObject:cell];
        }
        _emitterLayer.emitterCells = arr;
        [self.view.layer addSublayer:_emitterLayer];
        
    }
    return _emitterLayer;
}
-(SCXWatchLIveEndView *)endView{

    if (!_endView) {
        _endView = [[SCXWatchLIveEndView alloc]init];
        __weak typeof(self)weakSelf = self;
        [_endView setLookOtherBlock:^{
            [weakSelf lookOtherLive];
        }];
        [_endView setQuitBlock:^{
            [weakSelf quit];
        }];
        [self.view addSubview:_endView];
        [self.view bringSubviewToFront:_endView];
        [_endView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        
    }
    return _endView;

}
-(BarrageRenderer *)renderer{

    if (!_renderer) {
        _renderer = [[BarrageRenderer alloc]init];
        _renderer.speed = 5;
        
        _renderer.canvasMargin = UIEdgeInsetsMake(self.view.height * 0.3, 10, self.view.height * 0.3, 10);
        
        _renderer.view.userInteractionEnabled = YES;
        //_renderer.view.backgroundColor = [UIColor redColor];
        [self.view addSubview:_renderer.view];
    }
    return _renderer;

}
-(SCXWatchLiveConnectView *)connectView{

    if (!_connectView) {
        _connectView = [[SCXWatchLiveConnectView alloc]init];
        _connectView.layer.cornerRadius = 40;
        _connectView.layer.masksToBounds = YES;
        
        [_connectView setUserInteractionEnabled:YES];
        __weak typeof(self)weakSlef = self;
        [_connectView setSelectOtherBlock:^(SCXNewResultModel * selectModel) {
//            [weakSlef.connectView removeOtherLiveView];
//            [weakSlef.connectView removeFromSuperview];
//            weakSlef.connectView = nil;
            weakSlef.model = selectModel;
        }];
        [self.view addSubview:_connectView];
        [_connectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
            make.right.mas_equalTo(self.view.mas_right).offset(-30);
            make.width.height.mas_equalTo(80);
        }];
        
    }
    return _connectView;
}
- (NSArray *)rendererTextArr
{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"danmu.plist" ofType:nil]];
}

#pragma mark -------------- 播放直播 -----------------

/**
 开始观看直播

 @param flv 直播流地址
 @param imageUrl 直播人图片
 */
- (void)beginWatchLiveWithLiveUrl:(NSString *)flv placeholderImageUrl:(NSString *)imageUrl{

    // 切换主播的时候，如果之前存在播放器，那么就将播放器移除掉
    if (_livePlayer) {
        if (_livePlayer) {
            [self.view insertSubview:self.placeHolderView aboveSubview:_livePlayer.view];
        }
        // 如果连麦试图存在的话，切换主播的时候要将之前的试图移除掉
        if (_connectView) {
            [_connectView removeFromSuperview];
            _connectView  = nil;
        }
        [_livePlayer shutdown];
        [_livePlayer.view removeFromSuperview];
        _livePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    // 取消之前的粒子动画
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
    __weak typeof(self)weakSelf = self;
    
    // 设置背景图片
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (image) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if (strongSelf) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.placeHolderView.image = [UIImage blurImage:image blur:0.8];
                    [strongSelf showGifAnimationWithImages:nil inView:self.placeHolderView];
                    
                });
                
            }
        }
    }];

    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    // 硬解码
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    // 设置音量，标准256
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // 设置最大FPS
    [options setPlayerOptionIntValue:30 forKey:@"max-fps"];
    // 跳帧开关
    [options setPlayerOptionIntValue:0 forKey:@"framedrop"];
    // 重连次数
    [options setPlayerOptionIntValue:1 forKey:@"reconnect"];
    // 是否自动转屏
    [options setPlayerOptionIntValue:0 forKey:@"auto_covert"];
    
    // 设置播放器
    IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:flv] withOptions:options];
    player.view.frame = self.view.bounds;
    self.livePlayer = player;
    // 是否自动播放，必须设置为NO，防止自动播放，才能更好的控制直播状态
    player.shouldAutoplay = NO;
    // 填充模式
    player.scalingMode = IJKMPMovieScalingModeAspectFill;
    [player prepareToPlay];
    [self.view insertSubview:player.view atIndex:0];
    [self initObserver];
    [self emitterLayer];
    
}
#pragma mark --------------  注册监听 -----------------

/**
 添加监听通知
 */
- (void)initObserver
{
    [self.livePlayer play];
    
    //    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.livePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.livePlayer];
}
#pragma mark -------------- 监听，用来监听直播的状态和是否完成 -----------------

/**
 播放完成监听
 */
- (void)didFinish{
    
    // 任何原因导致直播暂停了，都要显示loading
    if (self.livePlayer.loadState & IJKMPMovieLoadStateStalled && !self.gifView) {
        [self showGifAnimationWithImages:nil inView:self.livePlayer.view];
        return;
    }
    
    // 从网络获取一下请求，如果还在继续的话那么是请求失败的，如果请求成功说明直播还在继续
    [SCXNetWorkHelp SCX_GetUrlToConnentNetWork:self.model.flv success:^(id result) {
        
    } failure:^(NSError *error) {
        // 关闭移除播放器，显示结束试图
        [self.livePlayer shutdown];
        [self.livePlayer.view removeFromSuperview];
        self.livePlayer = nil;
        self.endView.hidden = NO;
    }];

}

/**
 播放状态改变监听
 */
- (void)stateDidChange{
    __weak typeof(self) weakSelf = self;
    if ((self.livePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.livePlayer.isPlaying) {
            [self.livePlayer play];
            [self.renderer start];
            [self.topView beginAnimation];
           // self.topView.allModels = self.allModels;
            [self sendRenderer];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideGufLoding];
               
                [weakSelf.placeHolderView removeFromSuperview];
                weakSelf.placeHolderView = nil;
            });
        }
        
    }
    // 网络不佳
    else if ((self.livePlayer.loadState & IJKMPMovieLoadStateStalled) != 0){
    
        [self showGifAnimationWithImages:nil inView:self.livePlayer.view];
    
    }
    
    // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
    if (self.gifView.isAnimating) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self hideGufLoding];
        });
    }
}
#pragma mark -------------- 逻辑处理 -----------------

/**
 观看其他主播
 */
- (void)lookOtherLive{

}

/**
 点击连麦试图
 */
- (void)clickConnectView{

}
/**
 退出
 */
-(void)quit{
    
    if (self.topView) {
        [self.topView removeFromSuperview];
        self.topView = nil;
    }
    if (self.bottomView ) {
        [self.bottomView removeFromSuperview];
        self.bottomView = nil;
    }
    if (self.otherLiveView) {
        [self.otherLiveView removeFromSuperview];
        self.otherLiveView = nil;
    }
    if (self.connectView) {
        [self.connectView removeOtherLiveView];
        [self.connectView removeFromSuperview];
        
        self.connectView = nil;
    }
    if (self.livePlayer) {
        [self.livePlayer pause];
        [self.livePlayer stop];
        [self.livePlayer shutdown];
        [self.livePlayer .view removeFromSuperview];
        self.livePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    if (self.endView) {
        [self.endView removeFromSuperview];
        self.endView = nil;
    }
    [_renderer pause];
    [_renderer stop];
    [_renderer.view removeFromSuperview];
    _renderer = nil;
    
    [self.emitterLayer removeFromSuperlayer];
    self.emitterLayer = nil;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark -------------- 弹幕相关 -----------------

/**
 发送弹幕
 */
- (void)sendRenderer{

    // 计算当前屏幕上所有弹幕的数量
    NSInteger rendererCount = [_renderer spritesNumberWithName:nil];
    
    if (rendererCount < 10) {
        self.renderer.speed = 3;
        [self.renderer receive:[self walkTextSpriteDescriptionWithDirection:BarrageWalkDirectionR2L]];
    }

}
- (BarrageDescriptor *)walkTextSpriteDescriptionWithDirection:(NSInteger )direction{

    BarrageDescriptor *description = [[BarrageDescriptor alloc]init];
    description.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    NSInteger arc4random =  arc4random_uniform((uint32_t) self.rendererTextArr.count);
    description.params[@"text"] = self.rendererTextArr[arc4random];
    description.params[@"textColor"] = Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
    description.params[@"spreed"] = @5;
    description.params[@"direction"] = @(direction);
    description.params[@"trackNumber"] = @(10);
    
    description.params[@"clickAction"] = ^{
       
       [MBProgressHUD showAlertMessage:description.params[@"text"]];
    };
    
    return description;
}
#pragma mark -------------- 动画 -----------------
/**
 展示loadingGIF动画

 @param images 动画数组
 @param view 站在到哪个试图
 */
- (void)showGifAnimationWithImages:(NSArray *)images inView:(UIView *)view{

    if (!view) {
        view = self.view;
    }
    [view addSubview:self.gifView];
    [_gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@70);
    }];
    
    if (images.count > 0) {
        self.gifView.animationImages = images;
    }
    [self.gifView startAnimating];
}

// 取消GIF加载动画
- (void)hideGufLoding
{
    [self.gifView stopAnimating];
    [self.gifView removeFromSuperview];
    self.gifView = nil;
}
@end
