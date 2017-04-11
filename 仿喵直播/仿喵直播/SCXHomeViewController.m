//
//  SCXHomeViewController.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/3.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXHomeViewController.h"

@interface SCXHomeViewController ()<UIScrollViewDelegate>

@end

@implementation SCXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self titleView];
    
    [self scrollView];
}

#pragma mark -------------- 懒加载 ----------------
-(SCXCustomTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[SCXCustomTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenW * 0.5, 40)];
        __block typeof(self)weakSelf = self;
        [_titleView setSelectBlock:^(SCXTitleViewType type) {
            weakSelf.scrollView.contentOffset = CGPointMake(type * ScreenW, 0);
        }];
        self.navigationItem.titleView = _titleView;
    }
    return _titleView;
}

-(SCXCustomScrollView *)scrollView{

    if (!_scrollView) {
        _scrollView = [[SCXCustomScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.mainVC = self;
        self.view  = _scrollView;
    }
    return _scrollView;
}

#pragma mark - scrollView 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger index = self.scrollView.contentOffset.x / ScreenW + 0.5;
    self.titleView.contentOffSet = self.scrollView.contentOffset;
    self.titleView.type = index;

}
@end
