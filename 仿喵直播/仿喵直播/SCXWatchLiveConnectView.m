//
//  SCXWatchLiveConnectView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/20.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXWatchLiveConnectView.h"

@implementation SCXWatchLiveConnectView
-(instancetype)init{

    if (self = [super init]) {
        
    }
    return self;
}
-(void)setModel:(SCXNewResultModel *)model{
    
    if (self.moivePlayer) {
        [self.moivePlayer pause];
        [self.moivePlayer stop];
        [self.moivePlayer.view removeFromSuperview];
        self.moivePlayer = nil;
    }

    _model = model;
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    // 只播放视频不播放声音
    [options setPlayerOptionIntValue:1 forKey:@"an"];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    self.moivePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:model.flv withOptions:options];
    self.moivePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    //self.moivePlayer.view.backgroundColor = [UIColor redColor];
    [self layoutIfNeeded];
    self.moivePlayer.view.frame = self.bounds;
    // 自动播放
    self.moivePlayer.shouldAutoplay = YES;
    [self addSubview:self.moivePlayer.view];
    [self.moivePlayer prepareToPlay];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickConnectView)]];

}
- (void)clickConnectView{

    if (self.selectOtherBlock) {
        self.selectOtherBlock(self.model);
    }

}
- (void)removeOtherLiveView{

    if (self.moivePlayer) {
        [self.moivePlayer pause];
        [self.moivePlayer stop];
        [self.moivePlayer.view removeFromSuperview];
        self.moivePlayer = nil;
    }
    [super removeFromSuperview];

}
@end
