//
//  SCXHotCell.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXHotCell.h"

@implementation SCXHotCell

-(void)setModel:(SCXNewResultModel *)model{

    //[self removeAllView];
    
    // 设置头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.smallpic] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    // 设置名字
    self.nameLabel.text = model.myname;
   
    // 设置等级
    self.starImageView.image = model.starImage;
    self.starImageView.hidden = !model.starlevel;
    
    // 设置粉丝数
    NSString *fans = [NSString stringWithFormat:@"%@人在看",model.allnum];
    NSRange range = [fans rangeOfString:[NSString stringWithFormat:@"%@",model.allnum]];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:fans];
    [attributeStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} range:range];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:214 / 256.0 green:64 / 256.0 blue:217 / 256.0 alpha:1]} range:range];
    self.fansLabel.attributedText = attributeStr;
    
    // 位置
    if (model.gps) {
        [self.locationBtn setTitle:model.gps forState:UIControlStateNormal];
    }
    
    // 设置房间号
    self.roomLabel.text = [NSString stringWithFormat:@"房间号：%@",model.roomid];
   
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];

}

#pragma mark -------------- 懒加载 -----------------
-(UIImageView *)iconImageView{

    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView setImage:[UIImage imageNamed:@"placeholder_head"]];
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;

}
-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor orangeColor];
        [_nameLabel setFont:[UIFont fontWithName:@"苹方-简 中粗体" size:15]];
        _nameLabel.text = @"直播名";
        _nameLabel.numberOfLines = 0;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
    
}
-(UIImageView *)starImageView{
    
    if (!_starImageView) {
        _starImageView = [[UIImageView alloc] init];
        [_starImageView setImage:[UIImage imageNamed:@"girl_star1_40x19"]];
        [self.contentView addSubview:_starImageView];
    }
    return _starImageView;
    
}
-(UIImageView *)shareView{
    if (!_shareView) {
        _shareView = [[UIImageView alloc]init];
        _shareView.image = [UIImage imageNamed:@"icon_share"];
        //_shareView.backgroundColor = [UIColor redColor];
        _shareView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_shareView];
    }
    return _shareView;
}
-(UILabel *)fansLabel{
    if (!_fansLabel) {
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.textColor = [UIColor redColor];
        _fansLabel.font = [UIFont systemFontOfSize:13];
        _fansLabel.text = @"66666666人在看";
        [self.contentView addSubview:_fansLabel];
    }
    return _fansLabel;

}
-(UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [[UIButton alloc] init];
        
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_locationBtn setTitle:@"北京市 朝阳区" forState:UIControlStateNormal];
        [_locationBtn setImage:[UIImage imageNamed:@"home_location_8x8"] forState:UIControlStateNormal];
        _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-10, 0, 0);
        [self.contentView addSubview:_locationBtn];
    }
    return _locationBtn;
}
-(UILabel *)roomLabel{
    if (!_roomLabel) {
        _roomLabel = [[UILabel alloc] init];
        _roomLabel.textColor = [UIColor colorWithRed:213 / 255.0 green:66 / 255.0 blue:246 / 255.0 alpha:1];
        _roomLabel.font = [UIFont systemFontOfSize:14];
        _roomLabel.text = @"房间号：888888";
        [self.contentView addSubview:_roomLabel];
    }
    return _roomLabel;

}
-(UIImageView *)bigImageView{

    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] init];
        [_bigImageView setImage:[UIImage imageNamed:@"profile_user_414x414"]];
        [self.contentView addSubview:_bigImageView];
    }
    return _bigImageView;
}
-(UILabel *)explanLabel{

    if (!_explanLabel) {
        _explanLabel = [[UILabel alloc] init];
        _explanLabel.textColor = [UIColor redColor];
        _explanLabel.text = @"进来看看主播在干嘛";
        [self.contentView addSubview:_explanLabel];
    }
    return _explanLabel;

}
-(UILabel *)tagLabel{

    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor = [UIColor redColor];
        _tagLabel.text = @"直播中";
        [self.contentView addSubview:_tagLabel];
    }
    return _tagLabel;
}

/**
 移除试图
 */
- (void)removeAllView{

    [self.iconImageView removeFromSuperview];
    self.iconImageView = nil;
    [self.nameLabel removeFromSuperview];
    self.nameLabel = nil;
    [self.starImageView removeFromSuperview];
    self.starImageView = nil;
    [self.shareView removeFromSuperview];
    self.shareView = nil;
    [self.fansLabel removeFromSuperview];
    self.fansLabel = nil;
    [self. locationBtn removeFromSuperview];
    self. locationBtn = nil;
    [self.roomLabel removeFromSuperview];
    self.roomLabel = nil;
    [self.bigImageView removeFromSuperview];
    self.bigImageView = nil;
    [self.tagLabel removeFromSuperview];
    self.tagLabel = nil;
    [self.explanLabel removeFromSuperview];
    self.explanLabel = nil;

}
-(void)layoutSubviews{

    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.contentView).offset(5);
        make.width.height.equalTo(@40);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.iconImageView.mas_top).offset(5);
      
        make.width.mas_lessThanOrEqualTo(200);
    }];
    
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
        make.top.mas_equalTo(self.nameLabel);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.starImageView.mas_right).offset(5);
        //make.top.mas_equalTo(self.starImageView).offset(5);
        make.width.height.mas_equalTo(40);
        
    }];
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.starImageView.mas_top).offset(5);
        make.left.mas_equalTo(self.shareView.mas_right).offset(-10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
    }];
    [self. locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.width.mas_lessThanOrEqualTo(self.contentView.frame.size.width / 2);
        
    }];
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self. locationBtn.mas_right).offset(10);
        make.top.mas_equalTo(self. locationBtn.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
    }];
    [self.bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(300);
        make.top.mas_equalTo(self. locationBtn.mas_bottom).offset(10);
    }];
    
}

@end
