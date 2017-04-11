//
//  SCXCarouselView.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/23.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCXCarouselView;
/**
 点击图片回调block

 @param index 点击的图片索引
 */
typedef void(^SCX_ClickImageblock)(NSInteger index);

/**
 轮播图的轮播效果

 - SCX_CarouselViewTypeScroll: 默认滚动样式
 - SCX_CarouselViewTypeFade: 渐隐样式
 */
typedef NS_ENUM(NSInteger , SCX_CarouselViewType) {

    SCX_CarouselViewTypeScroll ,
    SCX_CarouselViewTypeFade // 渐隐的感觉

};

/**
 轮播图pageControl显示的位置

 - SCX_PageControlPositionNone: 默认位置，默认为中下
 - SCX_PageControlPositionTopCenter: 中上
 - SCX_PageControlPositionHide: 隐藏
 - SCX_PageControlPositionBottomLeft: 左下
 - SCX_PageControlPositionBottomCenter: 中下
 - SCX_PageControlPositionBottomRight: 右下
 */
typedef NS_ENUM(NSInteger , SCX_PageControlPosition) {

    SCX_PageControlPositionNone ,
    SCX_PageControlPositionTopCenter ,
    SCX_PageControlPositionHide ,
    SCX_PageControlPositionBottomLeft ,
    SCX_PageControlPositionBottomCenter ,
    SCX_PageControlPositionBottomRight

};

/**
 轮播图代理方法,如果和回调block同事调用，优先处理block
 */
@protocol SCXCarouselViewDelegate <NSObject>

/**
 点击的轮播图回调

 @param carouselView 当前轮播图
 @param index 当前点击的图片index
 */
- (void)scxCarouselView:(SCXCarouselView *)carouselView clickImageIndex:(NSInteger)index;

@end

@interface SCXCarouselView : UIView


/*************  轮播图片数组 ***************/
@property ( nonatomic , strong )NSMutableArray *imagesArr;

/*************  轮播图片描述数组 ***************/
@property ( nonatomic , strong )NSMutableArray *descriptionArr;

/*************  点击轮播图片回调block ***************/
@property ( nonatomic , copy )SCX_ClickImageblock clickBlock;

/*************  代理方法 ***************/
@property ( nonatomic , weak )id <SCXCarouselViewDelegate> delegate;

/*************  轮播图的动画类型 ***************/
@property ( nonatomic , assign )SCX_CarouselViewType carouselViewAnimationType;

/*************  轮播图pageControl显示位置 ***************/
@property ( nonatomic , assign )SCX_PageControlPosition pageControlPosition;

/*************  轮播的时候，每一张图片显示的时间 ***************/
@property ( nonatomic , assign )NSTimeInterval time;

/**
 *  是否开启图片缓存，默认为YES,必须在设置轮播数组之前调用，否则无效
 */
@property (nonatomic, assign) BOOL autoCache;


/**
 开始轮播
 */
- (void)startCarousel;

/**
 *  C语言函数，创建本地gif图片
 *  本地gif图片请使用该函数创建，否则gif无动画效果
 *  @param imageName 图片名称
 */
UIImage *gifImageNamed(NSString *imageName);


@end
