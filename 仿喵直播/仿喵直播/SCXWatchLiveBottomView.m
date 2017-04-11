//
//  SCXWatchLiveBottomView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXWatchLiveBottomView.h"

@implementation SCXWatchLiveBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

- (NSArray *)tools
{
    return @[@"talk_public_40x40", @"talk_private_40x40", @"talk_sendgift_40x40", @"talk_rank_40x40", @"talk_share_40x40", @"talk_close_40x40"];
}

- (void)setupBasic
{
    CGFloat wh = 40;
    CGFloat margin = (ScreenW - wh * self.tools.count) / (self.tools.count + 1.0);
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i<self.tools.count; i++) {
        x = margin + (margin + wh) * i;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        btn.userInteractionEnabled = YES;
        btn.tag = i;
        btn.image = self.tools[i];
        
        [btn addTarget:self action:@selector(click:)];
        
        [self addSubview:btn];
    }
}

- (void)click:(UIButton *)btn
{
    if (self.clickToolBlock) {
        self.clickToolBlock(btn.tag);
    }
}

@end
