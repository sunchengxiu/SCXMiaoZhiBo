//
//  SCXCustomTitleView.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXCustomButton.h"
/****************** titleType *******************/
typedef NS_ENUM(NSInteger , SCXTitleViewType) {

    SCXTitleViewTypeHot = 0 , // 热门
    SCXTitleViewTypeNew , // 最新
    SCXTitleViewTypeAttention // 关注

};




@interface SCXCustomTitleView : UIView

/*************  titleType ***************/
@property ( nonatomic , assign )SCXTitleViewType type;


/*************  lineView ***************/
@property ( nonatomic , strong )UIView *lineView;

/*************  selectBlock ***************/
@property ( nonatomic , copy )void (^selectBlock)(SCXTitleViewType);

/*************  选中的button ***************/
@property ( nonatomic , strong )UIButton *selectButton;


/*************  滚动偏移量 ***************/
@property ( nonatomic , assign )CGPoint contentOffSet;


@end
