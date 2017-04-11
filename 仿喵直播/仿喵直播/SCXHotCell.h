//
//  SCXHotCell.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXBaseTableViewCell.h"
#import "SCXNewResultModel.h"
@interface SCXHotCell : SCXBaseTableViewCell

/*************  数据模型 ***************/
@property ( nonatomic , strong )SCXNewResultModel *model;

/*************  iconImageView ***************/
@property ( nonatomic , strong )UIImageView *iconImageView;

/*************  标题Label ***************/
@property ( nonatomic , strong )UILabel *nameLabel;

/*************  starImageView ***************/
@property ( nonatomic , strong )UIImageView *starImageView;

/*************  分享按钮 ***************/
@property ( nonatomic , strong )UIImageView *shareView;

/*************  fanslabel ***************/
@property ( nonatomic , strong )UILabel *fansLabel;

/*************  位置label ***************/
@property ( nonatomic , strong )UIButton *locationBtn;

/*************  房间号Label ***************/
@property ( nonatomic , strong )UILabel *roomLabel;

/*************  大图label ***************/
@property ( nonatomic , strong )UIImageView *bigImageView;

/*************  直播介绍label ***************/
@property ( nonatomic , strong )UILabel *explanLabel;

/*************  直播标签label ***************/
@property ( nonatomic , strong )UILabel *tagLabel;

/*************  cell高度 ***************/
@property ( nonatomic , assign )CGFloat height;

+ (CGFloat)heightWithModel:(SCXNewResultModel *)model tableView : (UITableView *)tableView;
@end
