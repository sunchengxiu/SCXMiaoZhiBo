//
//  SCXCarouselView.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/23.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXCarouselView.h"
#import <ImageIO/ImageIO.h>
#define DescriptionLabelHeight 20
#define CarouselTimer  2
#define SCX_CacheFolder @"SCX_CacheFolder"
static NSString *cache;

/**
 私有变量
 */
@interface SCXCarouselView()<UIScrollViewDelegate>


/*************  轮播数组 ***************/
@property ( nonatomic , strong )NSMutableArray *images;

/*************  图片描述label ***************/
@property ( nonatomic , strong )UILabel *descriptionLabel;

/*************  滚动试图 ***************/
@property ( nonatomic , strong )UIScrollView *scrollView;

/*************  当前显示的图片 ***************/
@property ( nonatomic , strong )UIImageView *currentImageView;

/*************  下一张图片 ***************/
@property ( nonatomic , strong )UIImageView *nextImageView;

/*************  占位图 ***************/
@property ( nonatomic , strong )UIImage *placeImage;

/*************  分页空间 ***************/
@property ( nonatomic , strong )UIPageControl *pageControl;

/*************  当前图片索引 ***************/
@property ( nonatomic , assign )NSInteger currentIndex;

/*************  下一张图片的索引 ***************/
@property ( nonatomic , assign )NSInteger nextIndex;

/*************  pageControl图片大小 ***************/
@property ( nonatomic , assign )CGSize pageControlSize;

/*************  轮播定时器 ***************/
@property ( nonatomic , strong )NSTimer *timer;

/*************  队列 ***************/
@property ( nonatomic , strong )NSOperationQueue *queue;

@end

@implementation SCXCarouselView

/**
 刚开始加载就创建缓存路径
 */
+ (void)initialize {
    cache = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:SCX_CacheFolder];
    BOOL isDir = NO;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:cache isDirectory:&isDir];
    if (!isExists || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cache withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

#pragma mark -------------- 初始化方法 -----------------
-(instancetype)init{

    if (self = [super init]) {
        self.autoCache = YES;
        [self configSubViews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.autoCache = YES;
        [self configSubViews];
    }
    return self;
}
#pragma mark -------------- 界面配置 -----------------
- (void)configSubViews{

    [self addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top).offset(self.height - DescriptionLabelHeight);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(DescriptionLabelHeight);
    }];
    
    
    
}
#pragma mark -------------- 轮播图数组 -----------------
-(void)setImagesArr:(NSMutableArray *)imagesArr{
    if (!imagesArr.count ) {
        return;
    }
    _imagesArr = imagesArr;
    _images = [NSMutableArray array];
    _currentIndex = 0;
    //从网络下载或者直接添加image
    for (NSInteger i =0 ; i< imagesArr.count; i++) {
        if ([imagesArr[i] isKindOfClass:[UIImage class]]) {
            [_images addObject:imagesArr[i]];
        }
        else if([imagesArr[i] isKindOfClass:[NSString class]] ){
        
            if (_placeImage) {
                [_images addObject:_placeImage];
            }
            else{
                [_images addObject:[UIImage imageNamed:@"placeholder_head"]];
            }
            [self cacheImages:i];
        }
    }
    
    self.pageControl.numberOfPages = imagesArr.count;
    self.currentImageView.image = _images[_currentIndex];
    // 当不设置pageControl的位置时候，默认为中下
    self.pageControlPosition = SCX_PageControlPositionBottomCenter;
   
    [self setScrollViewContentSize];
    
//    // 开始轮播
//    [self startCarousel];

}
#pragma mark -------------- 定制化设置 -----------------

/**
 设置scrollView的contentSize
 */
- (void)setScrollViewContentSize{

    // 思想就是滚动scrollView，两个imageView变换就行，1，2，1，2原则，，所以contentView没有必要设置的很大
    // 让scrollView始终显示中间的那张图片，要显示的要么在他的右边，要么在他的左边
    // 如果只有一张图片，那么就不存在滚动
    if (self.images.count > 1) {
        self.scrollView.contentSize = CGSizeMake(self.width * 5, self.height);
        // 让scrollView便宜到中间，显示最中间的图片
        [self.scrollView setContentOffset:CGPointMake(self.width *2, 0)];
        
        // 渐隐动画位置特殊,当前图片和下一张图片位置重叠，只需要更改透明度就行了
        if (self.carouselViewAnimationType == SCX_CarouselViewTypeFade) {
            self.currentImageView.frame = CGRectMake(self.width * 2, 0, self.width, self.height);
            self.nextImageView.frame = self.currentImageView.frame;
            self.nextImageView.alpha = 0;
            
            [self.scrollView insertSubview:self.currentImageView atIndex:0  ];
            [self.scrollView insertSubview:self.nextImageView atIndex:1];
        }
        else{
            //让当前显示的图片居中
            self.currentImageView.frame = CGRectMake(self.width * 2, 0, self.width, self.height);
        }
        
    }
    else{
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.currentImageView.frame = CGRectMake(0, 0, self.width, self.height);
        // 一张图片禁止轮播
        [self stopCarousel];
    }
    // 不写这句话，pageControl会被遮住
    [self insertSubview:self.pageControl aboveSubview:self.currentImageView];
}

/**
 设置pageControl的位置

 @param pageControlPosition pageControl的位置
 */
-(void)setPageControlPosition:(SCX_PageControlPosition)pageControlPosition{

    _pageControlPosition = pageControlPosition;
    
    // 是否隐藏pageControll
    self.pageControl.hidden = (pageControlPosition == SCX_PageControlPositionHide) || (self.imagesArr.count == 1);
    if (self.pageControl.hidden) {
        return;
    }

    // 设置pageControll
    CGSize size;
    // 判断是否设置了pageImageSize
    if (!_pageControlSize.width) {
        size = [self.pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
        size.height = 8;
    }
    else{
        size = CGSizeMake(_pageControlSize.width * _pageControl.numberOfPages + 6 * _pageControl.numberOfPages, _pageControlSize.height);
    }
    self.pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    
    // 当有描述Label的时候，pageControl的位置要上移一个描述label的位置和一个占位
    CGFloat centerY = self.height - 10 - size.height * 0.5 - (self.descriptionLabel.hidden ? 0 : self.descriptionLabel.height);
    CGFloat Y = self.height - size.height - 10 - (self.descriptionLabel.hidden ? 0 : self.descriptionLabel.height);
    switch (pageControlPosition) {
        case SCX_PageControlPositionNone :
            case SCX_PageControlPositionBottomCenter:
        {
            _pageControl.center = CGPointMake(self.width * 0.5, centerY);
        }
            break;
            case SCX_PageControlPositionBottomLeft:
        {
            self.pageControl.frame = CGRectMake(10, Y, size.width, size.height);
        }
            break;
            case SCX_PageControlPositionBottomRight:
        {
            _pageControl.frame = CGRectMake(self.width - 10 - size.width, Y, size.width, size.height);
        }
            break;
        case SCX_PageControlPositionTopCenter:{
        
            self.pageControl.center = CGPointMake(self.width * 0.5, size.height * 0.5 + 10);
        }
            break;
        default:
            break;
    }
}

/**
 设置轮播图动画效果

 @param carouselViewAnimationType 动画类型
 */
- (void)setCarouselViewAnimationType:(SCX_CarouselViewType)carouselViewAnimationType{
    _carouselViewAnimationType = carouselViewAnimationType;
    if (_carouselViewAnimationType == SCX_CarouselViewTypeFade) {
        self.currentImageView.frame = CGRectMake(0, 0, self.width, self.height);
        self.nextImageView.frame = self.currentImageView.frame;
        self.nextImageView.hidden = 0;
        [self.currentImageView removeFromSuperview];
        [self.nextImageView removeFromSuperview];
        //[self.scrollView removeFromSuperview];
        [self addSubview:self.currentImageView];
        [self addSubview:self.nextImageView];
        // 不写这句话，pageControl会被遮住
        [self insertSubview:self.pageControl aboveSubview:self.currentImageView];
      
    }
    //[self setScrollViewContentSize];

}
#pragma mark -------------- 缓存图片 -----------------

/**
 下载gif图片

 @param index 下载的图片索引
 */
- (void)cacheImages:(NSInteger)index{
    
    NSString *urlString = self.imagesArr[index];
    NSString *imageName = [NSString md5:urlString];
    NSString *path = [cache stringByAppendingPathComponent:imageName];
    if (_autoCache) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            self.images[index] = getImageWithData(data);
            return;
        }
    }
    //下载图片
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (!data) {
            return;
        }
        UIImage *image = getImageWithData(data);
        if (image) {
            self.images[index] = image;
            if (self.currentIndex == index){
                [self.currentImageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
            }
            if (_autoCache) {
                [data writeToFile:path atomically:YES];
            }
        }
    }];
    [self.queue addOperation:operation];

}
#pragma mark 清除沙盒中的图片缓存
+ (void)clearDiskCache {
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cache error:NULL];
    for (NSString *fileName in contents) {
        [[NSFileManager defaultManager] removeItemAtPath:[cache stringByAppendingPathComponent:fileName] error:nil];
    }
}
#pragma mark -------------- 开始轮播 -----------------

/**
 开始轮播
 */
- (void)startCarousel{
    if (self.imagesArr.count < 1) {
        return;
    }
    if (self.timer) {
        [self stopCarousel];
    }
   
    // 开始轮播
    self.timer = [NSTimer timerWithTimeInterval:_time < CarouselTimer ? CarouselTimer : _time target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

/**
 停止轮播
 */
- (void)stopCarousel{
    
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)nextImage{

    // 如果是渐隐的话，位置不变，改变透明度就行
    if (self.carouselViewAnimationType == SCX_CarouselViewTypeFade) {
        // 切换到下一张图片
        @SCXWeakSlef(self);
        self.nextIndex = (self.currentIndex +1) % (self.images.count);
        self.nextImageView.image = self.images[self.nextIndex];
        NSTimeInterval time = _time < CarouselTimer ? CarouselTimer : _time;
        [UIView animateWithDuration:time / 3 animations:^{
            self.nextImageView.alpha = 1;
           self.currentImageView.alpha = 0;
            self.pageControl.currentPage = self.nextIndex;
        } completion:^(BOOL finished) {
             self.currentImageView.alpha = 0;
            @SCXStrongSelf(self);
            [strongself changeToNext];
        }];
    }
    else{
    
        // 如果是滚动的话 从2偏移量定位到3偏移量，当偏移的时候，就会调用scrollDidScroll
        [self.scrollView setContentOffset:CGPointMake(self.width * 3, 0) animated:YES];
    }
}

- (void)changeToNext{
    
    self.currentImageView.image = self.nextImageView.image;
    
    if (self.carouselViewAnimationType == SCX_CarouselViewTypeFade) {
        self.currentImageView.alpha = 1;
        self.nextImageView.alpha = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0) ];
   
    self.currentIndex = self.nextIndex;
    self.pageControl.currentPage = self.currentIndex;
    self.descriptionLabel.text = self.descriptionArr[self.currentIndex];

}
#pragma mark -------------- 懒加载 -----------------

-(UIScrollView *)scrollView{

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCarouselView)]];
        [self.scrollView addSubview:self.currentImageView];
        [self.scrollView addSubview:self.nextImageView];
        [self.scrollView addSubview:self.descriptionLabel];
        [self addSubview:self.pageControl];
        
        
    }
    return _scrollView;
}
-(UIImageView *)currentImageView{

    if (!_currentImageView) {
        _currentImageView = [[UIImageView alloc]init];
        _currentImageView.clipsToBounds = YES;
        
    }
    return _currentImageView;

}
-(UIImageView *)nextImageView{

    if (!_nextImageView) {
        _nextImageView = [[UIImageView alloc]init];
        _nextImageView.clipsToBounds = YES;
        
    }
    return _nextImageView;
}
-(UILabel *)descriptionLabel{

    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]init];
        _descriptionLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.font = [UIFont systemFontOfSize:13];
        _descriptionLabel.hidden = YES;
    }
    return _descriptionLabel;

}
-(UIPageControl *)pageControl{

    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];

    }
    return _pageControl;

}
-(NSOperationQueue *)queue{

    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}
#pragma mark -------------- 逻辑事件处理 -----------------

/**
 图片点击回调
 */
- (void)clickCarouselView{

    if (self.clickBlock) {
        self.clickBlock(self.currentIndex);
    } else if ([_delegate respondsToSelector:@selector(scxCarouselView:clickImageIndex:)]){
        [_delegate scxCarouselView:self clickImageIndex:self.currentIndex];
    }
}

#pragma mark -------------- scrollViewdelegate -----------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetx = scrollView.contentOffset.x;
    
    
        // 向左滑动
        if (offsetx < self.width * 2) {
            self.nextIndex = (self.currentIndex - 1);
            if (self.nextIndex < 0 ) {
                self.nextIndex = self.images.count - 1;
            }
            if (self.carouselViewAnimationType == SCX_CarouselViewTypeFade) {
                self.nextImageView.image = self.images[self.nextIndex];
                self.nextImageView.alpha = 2 - offsetx / self.width ;
                self.currentImageView.alpha = offsetx / self.width - 1;
              
                
            }
            else{
                self.nextImageView.frame = CGRectMake(CGRectGetMaxX(_currentImageView.frame), 0, self.width, self.height);
                self.nextImageView.image = self.images[self.nextIndex];
                self.nextImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
                
                
            }
            if (offsetx <= self.width) {
                [self changeToNext];
            }
            return;
        }
        // 向右滑动
        else if (offsetx > self.width * 2){
            self.nextIndex = (self.currentIndex + 1) % self.images.count;
            if (self.carouselViewAnimationType == SCX_CarouselViewTypeFade) {
                 self.nextImageView.image = self.images[self.nextIndex];
                self.nextImageView.alpha = offsetx / self.width - 2;
                self.currentImageView.alpha = 3 - offsetx / self.width;
                
                
            }else{
                
                self.nextImageView.frame = CGRectMake(CGRectGetMaxX(self.currentImageView.frame), 0, self.width, self.height);
                self.nextImageView.image = self.images[self.nextIndex];
                
            }
            // 继续从头滚动
            if (offsetx >= self.width * 3) {
            
                [self changeToNext];
            }
        }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    
   
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopCarousel];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startCarousel];
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}
#pragma mark -------------- GIF图片处理 -----------------
UIImage *gifImageNamed(NSString *imageName) {
    
    if (![imageName hasSuffix:@".gif"]) {
        imageName = [imageName stringByAppendingString:@".gif"];
    }
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    if (data) return getImageWithData(data);
    
    return [UIImage imageNamed:imageName];
}
#pragma mark 下载图片，如果是gif则计算动画时长
UIImage *getImageWithData(NSData *data) {
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(imageSource);
    if (count <= 1) { //非gif
        CFRelease(imageSource);
        return [[UIImage alloc] initWithData:data];
    } else { //gif图片
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0;
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
            if (!image) continue;
            duration += durationWithSourceAtIndex(imageSource, i);
            [images addObject:[UIImage imageWithCGImage:image]];
            CGImageRelease(image);
        }
        if (!duration) duration = 0.1 * count;
        CFRelease(imageSource);
        return [UIImage animatedImageWithImages:images duration:duration];
    }
}


#pragma mark 获取每一帧图片的时长

float durationWithSourceAtIndex(CGImageSourceRef source, NSUInteger index) {
    float duration = 0.1f;
    CFDictionaryRef propertiesRef = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *properties = (__bridge NSDictionary *)propertiesRef;
    NSDictionary *gifProperties = properties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTime = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTime) duration = delayTime.floatValue;
    else {
        delayTime = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTime) duration = delayTime.floatValue;
    }
    CFRelease(propertiesRef);
    return duration;
}
@end
