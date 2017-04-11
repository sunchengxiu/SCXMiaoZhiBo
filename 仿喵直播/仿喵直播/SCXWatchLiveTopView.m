//
//  SCXWatchLiveTopView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXWatchLiveTopView.h"

@implementation SCXWatchLiveTopView

-(instancetype)init{

    if (self = [super init]) {
        [self configViews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self configViews];
    }
    return self;
}
-(void)setModel:(SCXNewResultModel *)model{

    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    self.nameLabel.text = model.myname;
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%@人", model.allnum];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateNum) userInfo:nil repeats:YES];
    self.iconimageView.userInteractionEnabled = YES;
    [self.iconimageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderView:)]];
    
    self.peopleCountLabel.adjustsFontSizeToFitWidth = YES;
    self.roomIDLable.adjustsFontSizeToFitWidth = YES;
    self.roomIDLable.text = [NSString stringWithFormat:@"房间号:%@",model.roomid];


}
-(void)setAllModels:(NSMutableArray *)allModels{
    
    _allModels = allModels;
    [self.otherLiveScrollView layoutIfNeeded];
    CGFloat margin = 10;
    // 宽度和高度等于scrollView的高度
    CGFloat width = self.otherLiveScrollView.height;
    
    if (self.otherLiveScrollView.contentSize.width < ScreenW) {
        self.otherLiveScrollView.contentSize = CGSizeMake(ScreenW, 0);
        
    }
    self.otherLiveScrollView.showsVerticalScrollIndicator = NO;
    self.otherLiveScrollView.showsHorizontalScrollIndicator = NO;
    NSInteger count = 15;
    if (allModels.count < count) {
        count = allModels.count;
    }
    self.otherLiveScrollView.contentSize = CGSizeMake(width * count , 0);
    self.otherLiveScrollView.userInteractionEnabled = YES;
    CGFloat viewWidth = self.otherLiveScrollView.height - 10;
    for (NSInteger i = 0 ; i < count; i ++ ) {
        
        CGFloat x = margin * (i + 1) + viewWidth * (i );
        CGFloat y = 5;
        UIButton *btn = ({
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, viewWidth, viewWidth)];
           
            button.tag = i;
            //[button setBackgroundColor:[UIColor redColor]];
            button.layer.cornerRadius = viewWidth * 0.5;
            button.layer.masksToBounds = YES;
            //button.userInteractionEnabled = YES;
            [button addTarget:self action:@selector(clickOtherLive:) forControlEvents:UIControlEventTouchUpInside];
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.toValue = @(M_PI * 2);
            animation.duration = 7;
            animation.repeatCount = MAXFLOAT;
            [button.layer addAnimation:animation forKey:@"ani"];
            button;
        });

        [self.otherLiveScrollView addSubview:btn];
        
        SCXNewResultModel *model = allModels[i];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.bigpic] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                [btn setImage:image forState:UIControlStateNormal];
            }
        }];
        
        
        
    }
}
- (void)beginAnimation{

    for (UIButton *btn in self.otherLiveScrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]] && (btn.tag >=0 && btn.tag <= 15)) {
            //CABasicAnimation *animation = [view.layer animationForKey:@"ani"];
            //UIButton *btn = (UIButton *)(view);
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.toValue = @(M_PI * 2);
            animation.duration = 7;
            animation.repeatCount = MAXFLOAT;
            [btn.layer addAnimation:animation forKey:@"ani"];
        }
    }

}

- (void)clickOtherLive:(UIButton *)btn{

    NSLog(@"点击第%ld个主播了",btn.tag);
}
static int randomNum = 0;

- (void)updateNum
{
    randomNum += arc4random_uniform(5);
    
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%ld人", [self.model.allnum integerValue] + randomNum];
    [self.GIFBtn setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u", 1993045 + randomNum,  124593+randomNum] forState:UIControlStateNormal];
}
- (void)clickHeaderView:(UITapGestureRecognizer *)tapGes
{
    if (self.selectBlock){
        self.selectBlock(_model,self.iconimageView.image);
    }
}
- (void)configViews{

    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self).offset(10);
        make.width.mas_offset(self.bounds.size.width - 20);
        make.height.mas_equalTo(60);
    }];
    
    [self.iconimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_top).offset(5);
        make.left.mas_equalTo(self.topView).offset(15);
        make.bottom.mas_equalTo(self.topView).offset(-5);
        make.width.mas_equalTo(self.iconimageView.mas_height);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconimageView.mas_top).offset(5);
        make.left.mas_equalTo(self.iconimageView.mas_right).offset(10);
        make.right.mas_equalTo(self.topView.mas_right).offset(-60);
    }];
    
    [self.peopleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(7);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        
    }];
    
    [self.roomIDLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.peopleCountLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        //make.right.mas_equalTo(self.topView.mas_right).offset(-60);
    }];
    
    [self.careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topView.mas_right).offset(-10);
        make.top.mas_equalTo(self.topView.mas_top).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_offset(30);
    }];
    
    [self.GIFBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.iconimageView.mas_left);
        make.height.mas_equalTo(30);
        
    }];
    
    

}
-(void)layoutSubviews{

    [super layoutSubviews];
    
}
#pragma mark -------------- 懒加载 -----------------
-(UIView *)topView{

    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.layer.cornerRadius = 20;
        _topView.layer.masksToBounds = YES;
        
        _topView.backgroundColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 / 255.0 alpha:0.5];
        

        [self addSubview:_topView];
    }
    return _topView;
}
-(UIImageView *)iconimageView{

    if (!_iconimageView) {
        _iconimageView = [[UIImageView alloc]init];
        [_iconimageView setImage:[UIImage imageNamed:@"placeholder_head"]];
        [self.topView addSubview:_iconimageView];
    }
    return _iconimageView;
}
-(UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setTextColor:[UIColor colorWithRed:213 / 255.0 green:66 / 255.0 blue:246 / 255.0 alpha:1]];
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        [_nameLabel setText:@"孙有型"];
        [self.topView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(UILabel *)peopleCountLabel{

    if (!_peopleCountLabel) {
        _peopleCountLabel = [[UILabel alloc] init];
        _peopleCountLabel.text = @"68753";
        [_peopleCountLabel setFont:[UIFont systemFontOfSize:13]];
        [_peopleCountLabel setTextColor:[UIColor redColor]];
        [self.topView addSubview:_peopleCountLabel];
    }
    return _peopleCountLabel;
}
-(UILabel *)roomIDLable{

    if (!_roomIDLable) {
        _roomIDLable = [[UILabel alloc]init];
        [_roomIDLable setText:@"86868"];
        [_roomIDLable setFont:[UIFont systemFontOfSize:15]];
        [_roomIDLable setTextColor:[UIColor redColor]];
        [self.topView addSubview:_roomIDLable];
    }
    return _roomIDLable;
}
-(UIButton *)GIFBtn{

    if (!_GIFBtn) {
        _GIFBtn = [[UIButton alloc] init];
        _GIFBtn.layer.cornerRadius = 10;
        _GIFBtn.layer.masksToBounds = YES;
        [_GIFBtn setImage:[UIImage imageNamed:@"cat_food_18x12"] forState:UIControlStateNormal];
        [_GIFBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_GIFBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        [_GIFBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_GIFBtn setTitle:@"猫粮:1993045  娃娃124593" forState:UIControlStateNormal];
        [_GIFBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _GIFBtn.backgroundColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 / 255.0 alpha:0.5];
        [self addSubview:_GIFBtn];
    }
    return _GIFBtn;

}
-(UIButton *)careBtn{

    if (!_careBtn) {
        _careBtn = [[UIButton alloc] init];
        _careBtn.layer.cornerRadius = 10;
        _careBtn.layer.masksToBounds = YES;
        [_careBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_careBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_careBtn setBackgroundColor:[UIColor purpleColor]];
        [self.topView addSubview:_careBtn];
    }
    return _careBtn;
}
-(UIScrollView *)otherLiveScrollView{

    if (!_otherLiveScrollView) {
        _otherLiveScrollView = [[UIScrollView alloc]init];
        _otherLiveScrollView.backgroundColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 / 255.0 alpha:0.5];
       
//        _otherLiveScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 60);
        [self addSubview:_otherLiveScrollView];
        [_otherLiveScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.GIFBtn.mas_bottom).offset(5);;
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(60);
        }];
    }
    return _otherLiveScrollView;
}

@end
