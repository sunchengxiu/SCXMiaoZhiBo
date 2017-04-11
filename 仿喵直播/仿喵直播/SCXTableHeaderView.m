//
//  SCXTableHeaderView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXTableHeaderView.h"
@interface SCXTableHeaderView()


/*************  左上角设置按钮 ***************/
@property ( nonatomic , strong )UIButton *setBtn;

/************* 头像 ***************/
@property ( nonatomic , strong )UIButton *iconBtn;

/*************  名字label ***************/
@property ( nonatomic , strong )UILabel *nameLabel;

/*************  振幅 , Y 最大偏移量***************/
@property ( nonatomic , assign )CGFloat amplitude;

/*************  波长 ***************/
@property ( nonatomic , assign )CGFloat waveLength;

/*************  偏移量 ***************/
@property ( nonatomic , assign )CGFloat offset;

/*************  波浪 ***************/
@property ( nonatomic , strong )CAShapeLayer *waveLayer;


/*************  传播周期 ***************/
@property ( nonatomic , assign )CGFloat weekend;

/*************  定时器 ***************/
@property ( nonatomic , strong )CADisplayLink *displayLink;

@end

@implementation SCXTableHeaderView

- (UIButton *)setBtn
{
    if (_setBtn == nil){
        
        _setBtn = [[UIButton alloc]init];
        [_setBtn setImage:[UIImage imageNamed:@"MoreSetting"] forState:UIControlStateNormal];
        [self addSubview:_setBtn];
    }
    return _setBtn;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil){
        
        UILabel *nameLabel = [[UILabel alloc] init];
        
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.numberOfLines = 0;
        
        nameLabel.text = @"昵称";
        nameLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:nameLabel];
        
        __weak typeof(self) weakSelf = self;
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
           /// make.width.mas_equalTo(300);
           
            make.top.equalTo(weakSelf.iconBtn.mas_bottom).offset(0);
            
            make.centerX.equalTo(weakSelf);
            
        }];
        
        _nameLabel = nameLabel;
    }
    
    return _nameLabel;
}


- (UIButton *)iconBtn
{
    if (_iconBtn == nil){
        
        _iconBtn = [[UIButton alloc]init];
        _iconBtn.layer.cornerRadius = 40;
        _iconBtn.layer.masksToBounds = YES;
        
        _iconBtn.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_iconBtn];
        
        __weak typeof(self) weakSelf = self;
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.width.equalTo(@80);
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-40);
            
        }];
        
    }
    return _iconBtn;
}

/**
 初始化

 @param frame 头部试图尺寸
 @param backgroundImageName 背景图
 @param iconImageName 头像
 @param title 标题
 */
- (instancetype)initWithFrame:(CGRect)frame backgroundImageName:(NSString *)backgroundImageName iconImageName:(NSString *)iconImageName titleName:(NSString *)title{

    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:backgroundImageName];
        [self.iconBtn setImage:[UIImage imageNamed:iconImageName] forState:UIControlStateNormal];
        self.nameLabel.text = title;
        
    }
    return self;
}

/**
 开始震动
 */
- (void)startWave{
    [self stopWave];
    // 初始化波长
    self.waveLength = self.width ;
    // 初始化周期
    self.weekend = 1;
    // 初始化振幅
    self.amplitude = 10;
    self.waveLayer = [CAShapeLayer layer];
    self.waveLayer.fillColor = [UIColor colorWithRed:242/255.0 green:247/255.0 blue:254/255.0 alpha:0.5].CGColor;
    [self.layer addSublayer:self.waveLayer];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawLayer)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

/**
 绘制波浪
 */
- (void)drawLayer{

    // 让振幅不断减小，效果就是类似于水波越来越小趋于平静的样子，一点一点消失
    self.amplitude -= 0.02;
    if (self.amplitude < 0.1) {
        [self stopWave];
    }
    // 让波浪平移
    self.offset += (ScreenW / 60 / self.weekend);
    self.waveLayer.path = [self drawPath].CGPath;

}
- (UIBezierPath *)drawPath{

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGMutablePathRef ref = CGPathCreateMutable();
    path.lineWidth = 2;
    CGPathMoveToPoint(ref, nil, 0, self.height);
    CGFloat y = 0 ;
    /**
     * *** 正玄波的基础知识  ***
     *
     *  f(x) = Asin(ωx+φ)+k
     *
     *  A    为振幅, 波在上下振动时的最大偏移
     *
     *  φ/w  为在x方向平移距离
     *
     *  k    y轴偏移，即波的振动中心线y坐标与x轴的偏移距离
     *
     *  2π/ω 即为波长，若波长为屏幕宽度即， SCREEN_W = 2π/ω, ω = 2π/SCREEN_W
     */
    // A = waveAmplitude  w = (2 * M_PI / waveLength) φ = (waveLength / 12) / (2 * M_PI / waveLength) k = headHeight - waveAmplitude （注意：坐标轴是一左上角为原点的）
    for (CGFloat x = 0.0; x <= ScreenW *2 ; x ++) {
        y = self.amplitude * sinf(((M_PI * 2) / (self.waveLength)) * (x + self.offset + _waveLength  / 12)) + self.height - self.amplitude;
        CGPathAddLineToPoint(ref, nil, x, y);
    }
    CGPathAddLineToPoint(ref, nil, ScreenW, self.height);
    CGPathCloseSubpath(ref);
    path.CGPath = ref;
    CGPathRelease(ref);
    return path;
    
}

/**
 停止震动
 */
- (void)stopWave{
    [self.waveLayer removeFromSuperlayer];
    self.waveLayer = nil;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
