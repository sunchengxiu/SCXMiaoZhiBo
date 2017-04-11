//
//  SCXUtil.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/10.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXUtil.h"

@implementation SCXUtil

/**
 普通下拉刷新

 @param block 下拉刷新回调
 */
+(void)SCX_addDownRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block{

}

/**
 普通上拉刷新
 
 @param block 上啦刷新回调
 */
+(void)SCX_addUpRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block{
    if (scrollView == nil || block == nil) {
        return;
    }
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    [footer setTitle:@"下拉刷新哦" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开刷新哦" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了哦" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.stateLabel.textColor = [UIColor orangeColor];
    scrollView.mj_footer = footer;
}

/**
 GIF下拉刷新
 
 @param block GIF下拉刷新回调
 */
+(void)SCX_addDownGIFRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block{
    if (scrollView == nil || block == nil) {
        return;
    }

    NSArray *refreshArr = @[[UIImage imageNamed:@"reflesh1_60x55"], [UIImage imageNamed:@"reflesh2_60x55"], [UIImage imageNamed:@"reflesh3_60x55"]];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    [header setImages:refreshArr forState:MJRefreshStateIdle];
    [header setImages:refreshArr forState:MJRefreshStatePulling];
    [header setImages:refreshArr forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor orangeColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    scrollView.mj_header = header;
}
@end
