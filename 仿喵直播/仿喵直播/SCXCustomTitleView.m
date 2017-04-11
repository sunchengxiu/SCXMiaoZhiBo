//
//  SCXCustomTitleView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXCustomTitleView.h"

@implementation SCXCustomTitleView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
       
        [self basicSetUp];
        [self lineView];
    }
    return self;
}
#pragma mark - 基本配置
- (void)basicSetUp{
    [self createBtnWithTile:@"热门" type:SCXTitleViewTypeHot];
    [self createBtnWithTile:@"最新" type:SCXTitleViewTypeNew];
    [self createBtnWithTile:@"关注" type:SCXTitleViewTypeAttention];
}
#pragma mark - 创建按钮
- (void)createBtnWithTile:(NSString *)title type:(SCXTitleViewType)tag{

    UIButton *btn = [SCXCustomButton createBtnWithTile:title type:tag superView:self];
    if (tag == 0) {
        [self titleButtonClick:btn];
    }
    [btn addTarget:self action:@selector(titleButtonClick:)];
   

}
- (void)titleButtonClick:(UIButton *)btn{
    self.selectButton.selected = NO;
    btn.selected = YES;
    self.selectButton = btn;
    
    if (self.selectBlock) {
        self.selectBlock(btn.tag);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.X(btn.x - 10);
    }];
}

-(void)setType:(SCXTitleViewType)type{
    _type = type;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.X(self.selectButton.x - 10);
    }];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == type) {
            self.selectButton.selected = NO;
            ((UIButton *)view).selected = YES;
            self.selectButton = ((UIButton *)view);
        }
    }

}

#pragma mark -------------- 懒加载 ----------------
-(UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.Height(4);
        _lineView.Width(self.selectButton.width + 20);
        _lineView.Y(self.height - _lineView.height);
        
        [self addSubview:_lineView];
    }
    return _lineView;
    
}
@end
