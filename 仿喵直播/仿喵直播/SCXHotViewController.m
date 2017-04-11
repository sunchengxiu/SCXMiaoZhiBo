//
//  SCXHotViewController.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/3.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXHotViewController.h"
#import "SCXCarouselView.h"
@interface SCXHotViewController ()
/*************  头部试图 ***************/
@property ( nonatomic , strong )SCXCarouselView *headerView;
@end

@implementation SCXHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 定制刷新种类
    self.refreshType = SCXREefreshTypeRefresh;
    
    // 默认第一次进入就开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.tableHeaderView = self.headerView;
    
    // 默认分页为1
    self.page = 1;
    
    [self loadHeaderData];
    // 获取刷新数据
    [self SCX_loadData];
  
}

-(SCXCarouselView *)headerView{

    if (!_headerView) {
        _headerView = [[SCXCarouselView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 200)];

        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;

}

/**
 加载滚动广告试图
 */
- (void)loadHeaderData{
    [SCXNetWorkHelp SCX_GetHeaderDataWithSuccess:^(SCXHeaderModel *model) {
        NSMutableArray *imageUrls = [NSMutableArray array];
        NSMutableArray *desArr = [NSMutableArray array];
        for (SCXHeaderResultModel *headerModel in model.data) {
            
            [imageUrls addObject:headerModel.imageUrl];
            [desArr addObject:@"图片描述文字"];
        }
        
        self.headerView.imagesArr = [NSMutableArray arrayWithArray:imageUrls];
        // 设置图片的描述文字数组
        _headerView.descriptionArr = [NSMutableArray arrayWithArray:desArr];
        // 设置pageControl的位置
        _headerView.pageControlPosition = SCX_PageControlPositionBottomLeft;
        //_headerView.carouselViewAnimationType = SCX_CarouselViewTypeFade;
        [_headerView setClickBlock:^ (NSInteger index){
        
            NSLog(@"点击第%ld张图片了",index);
        
        }];
        [_headerView startCarousel];
        
        
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 获取热门数据,分页
 */
- (void)SCX_loadData{

    [SCXNetWorkHelp SCX_GetHotDataWithPage:self.page success:^(SCXNewModel *model) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self SCX_endRefresh];
        });
        // 解析数据模型
        SCXNewData *newModel = [SCXNewData mj_objectWithKeyValues:model.data];
        self.data = newModel;
        if (newModel.list.count > 0) {
            [self.dataArray addObjectsFromArray:newModel.list];
            [self SCX_reloadData];
        }
        else{
            [MBProgressHUD showAlertMessage:@"暂时没有更多数据哦"];
            self.page --;
        }
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self SCX_endRefresh];
        });
        //self.page --;
        [MBProgressHUD showAlertMessage:@"网络异常"];
    } ];
    
    

}


#pragma mark -------------- tableView代理方法 -----------------
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SCXHotCell *cell = [SCXHotCell cellWithTableView:self.tableView];
    SCXNewResultModel *model = self.dataArray[indexPath.row];
   
    cell.model = model;
    
    return cell;

}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXHotCell *cell = [self SCX_tableViewCellForRowAtIndexPath:indexPath];
  
    [cell layoutIfNeeded];
    return CGRectGetMaxY(cell.bigImageView.frame) + 10;
   // return [SCXHotCell heightWithModel:self.dataArray[indexPath.row] tableView:self.tableView];
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell{

    SCXWatchLiveViewController *watch = [[SCXWatchLiveViewController alloc]init];
    
    watch.allModels = self.dataArray;
    watch.model = self.dataArray[indexPath.row];
    
    [self SCX_PresentViewController:watch];
    
}
-(void)SCX_tableViewWillDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.transform = CGAffineTransformMakeTranslation(0, 30);
    [UIView animateWithDuration:1 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];

}

@end
