//
//  SCXWatchLIveEndView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXWatchLIveEndView.h"

@implementation SCXWatchLIveEndView
-(instancetype)init{

    if (self = [super init]) {
        [self configViews];
    }
    return self;

}
- (void)configViews{

    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backImageView).offset(64);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.backImageView.mas_left).offset(30);
        make.right.mas_equalTo(self.backImageView.mas_right).offset(-30);
    }];
    [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oneLine.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.endLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.backImageView.mas_left).offset(30);
        make.right.mas_equalTo(self.backImageView.mas_right).offset(-30);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.twoLine.mas_bottom).offset(100);
        make.centerX.mas_equalTo(self);
    }];
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.endTimeLabel.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self);
    }];
    [self.countNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
    }];
    [self.careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countNameLabel.mas_bottom).offset(80);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self.oneLine.mas_width);
    }];
    [self.otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.careBtn.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self.oneLine.mas_width);
    }];
    [self.quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.otherBtn.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self.oneLine.mas_width);
    }];
}

#pragma mark -------------- 懒加载 -----------------
-(UIView *)oneLine{
 
    if (!_oneLine) {
        _oneLine = [[UIView alloc]init];
        [_oneLine setBackgroundColor:[UIColor whiteColor]];
        [self.backImageView addSubview:_oneLine];
    }
    return _oneLine;
}
-(UIView *)twoLine{
    
    if (!_twoLine) {
        _twoLine = [[UIView alloc]init];
        [_twoLine setBackgroundColor:[UIColor whiteColor]];
        [self.backImageView addSubview:_twoLine];
    }
    return _twoLine;
}
-(UILabel *)endLabel{

    if (!_endLabel) {
        _endLabel = [[UILabel alloc]init];
        [_endLabel setFont:[UIFont fontWithName:@"ArialMT" size:24]];
        [_endLabel setTextColor:[UIColor whiteColor]];
        _endLabel.text = @"直播结束";
        [self.backImageView addSubview:_endLabel];
    }
    return  _endLabel;
}
-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setFont:[UIFont fontWithName:@"ArialMT" size:20]];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        _timeLabel.text = @"2小时20分钟";
        [self.backImageView addSubview:_timeLabel];
    }
    return  _timeLabel;
}
-(UILabel *)endTimeLabel{
    
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc]init];
        [_endTimeLabel setFont:[UIFont fontWithName:@"ArialMT" size:18]];
        [_endTimeLabel setTextColor:[UIColor whiteColor]];
        _endTimeLabel.text = @"直播时长";
        [self.backImageView addSubview:_endTimeLabel];
    }
    return  _endTimeLabel;
}
-(UILabel *)countLabel{
    
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        [_countLabel setFont:[UIFont fontWithName:@"ArialMT" size:20]];
        [_countLabel setTextColor:[UIColor whiteColor]];
        _countLabel.text = @"53286";
        [self.backImageView addSubview:_countLabel];
    }
    return  _countLabel;
}
-(UILabel *)countNameLabel{
    
    if (!_countNameLabel) {
        _countNameLabel = [[UILabel alloc]init];
        [_countNameLabel setFont:[UIFont fontWithName:@"ArialMT" size:18]];
        [_countNameLabel setTextColor:[UIColor whiteColor]];
        _countNameLabel.text = @"观看人数";
        [self.backImageView addSubview:_countNameLabel];
    }
    return  _countNameLabel;
}
-(UIButton *)careBtn{
 
    if (!_careBtn) {
        _careBtn = [[UIButton alloc] init];
        [_careBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [_careBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_careBtn setBackgroundColor:[UIColor purpleColor]];
        _careBtn.layer.cornerRadius = 8;
        _careBtn.layer.masksToBounds = YES;
        [self.backImageView addSubview:_careBtn];
    }
    return _careBtn;
}
-(UIButton *)otherBtn{
    
    if (!_otherBtn) {
        _otherBtn = [[UIButton alloc] init];
        [_otherBtn setTitle:@"查看房间其他主播" forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_otherBtn setBackgroundColor:[UIColor clearColor]];
        _otherBtn.layer.cornerRadius = 8;
        _otherBtn.layer.masksToBounds = YES;
        _otherBtn.layer.borderWidth = 1;
        _otherBtn.layer.borderColor = [UIColor purpleColor].CGColor;
        [_otherBtn addTarget:self action:@selector(lookOther) forControlEvents:UIControlEventTouchUpInside];
        [self.backImageView addSubview:_otherBtn];
    }
    return _otherBtn;
}
-(UIButton *)quitBtn{
    
    if (!_quitBtn) {
        _quitBtn = [[UIButton alloc] init];
        [_quitBtn setTitle:@"退出直播间" forState:UIControlStateNormal];
        [_quitBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_quitBtn setBackgroundColor:[UIColor clearColor]];
        _quitBtn.layer.cornerRadius = 8;
        _quitBtn.layer.masksToBounds = YES;
        _quitBtn.layer.borderWidth = 1;
        _quitBtn.layer.borderColor = [UIColor purpleColor].CGColor;
     
        [_quitBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
        _quitBtn.userInteractionEnabled = YES;
        [self.backImageView addSubview:_quitBtn];
    }
    return _quitBtn;
}
-(UIImageView *)backImageView{

    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.image = [UIImage imageNamed:@"private_bg_375x229"];
        _backImageView.userInteractionEnabled = YES;
        [self addSubview:_backImageView];
    }
    return _backImageView;
}
- (void)lookOther{

    if (self.lookOtherBlock) {
        self.lookOtherBlock();
    }
}
- (void)quit{

    if (self.quitBlock) {
        self.quitBlock();
    }
}
@end
