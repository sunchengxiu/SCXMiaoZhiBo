//
//  SCXPersionalController.m
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/6.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "SCXPersionalController.h"

@interface SCXPersionalController ()

@end

@implementation SCXPersionalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addSubview: self.headerView];
    // 与图像高度一样防止数据被遮挡
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW , self.headerView.height )];
   
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    UINavigationBar *bar = self.navigationController.navigationBar;
    bar.hidden = YES;
    [self.tableView reloadData];
}
-(SCXTableHeaderView *)headerView{

    if (!_headerView) {
       
        _headerView = [[SCXTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 270) backgroundImageName:@"屏幕快照 2017-03-22 下午4.35.16" iconImageName:@"icon" titleName:@"孙承秀仿喵直播"];
    }
    return _headerView;

}
- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableDictionary *miaoBi = [NSMutableDictionary dictionary];
        miaoBi[@"title"] = @"我的喵币";
        miaoBi[@"icon"] = @"ic_account_balance_wallet_black_24dp1";
        
        //自己写要跳转到的控制器
        miaoBi[@"controller"] = [SCXOtherViewController class];
        
        NSMutableDictionary *zhiBoJian = [NSMutableDictionary dictionary];
        zhiBoJian[@"title"] = @"直播间管理";
        zhiBoJian[@"icon"] = @"MoreExpressionShops";
        //自己写要跳转到的控制器
        zhiBoJian[@"controller"] = [SCXOtherViewController class];
        
        NSMutableDictionary *shouYi = [NSMutableDictionary dictionary];
        shouYi[@"title"] = @"我的收益";
        shouYi[@"icon"] = @"MoreMyBankCard";
        shouYi[@"controller"] = [SCXOtherViewController class];
        
        NSMutableDictionary *liCai = [NSMutableDictionary dictionary];
        liCai[@"title"] = @"微钱进理财";
        liCai[@"icon"] = @"buyread";
        liCai[@"controller"] = [SCXOtherViewController class];
        
        NSMutableDictionary *cleanCache = [NSMutableDictionary dictionary];
        cleanCache[@"title"] = @"清空缓存";
        cleanCache[@"icon"] = @"img_cache";
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"设置";
        setting[@"icon"] = @"MoreSetting";
        setting[@"controller"] = [SCXOtherViewController class];
        
        NSArray *section1 = @[miaoBi, zhiBoJian];
        NSArray *section2 = @[shouYi, liCai];
        NSArray *section3 = @[cleanCache];
        NSArray *section4 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section1, section2, section3,section4, nil];
    }
    return _dataList;
}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataList.count;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    if (!indexPath.section && !indexPath.row) {
        cell.detailTextLabel.text = @"270枚";
        cell.detailTextLabel.textColor = Color(0.935, 210, 0);
    }
    
    cell.selected = YES;
    
    if ([cell.textLabel.text isEqualToString:@"清空缓存"]){
        
        cell.accessoryView = [[UIView alloc] init];
        cell.detailTextLabel.text = [self caCheSize];
    }
    
    return cell;
    
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataList[section];
    return arr.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !section ? 1 : 20;
}
- (NSString *)caCheSize
{

    NSString *detailTitle = nil;
    CGFloat size = [SDImageCache sharedImageCache].getSize;
    
    if (size > 1024 * 1024){
        detailTitle = [NSString stringWithFormat:@"%.02fM",size / 1024 / 1024];
    }else if (size > 1024){
        detailTitle = [NSString stringWithFormat:@"%.02fKB",size / 1024];
    }else{
        detailTitle = [NSString stringWithFormat:@"%.02fB",size];
    }
    
    return detailTitle;
}
-(void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell{

   
    if (self.dataList[indexPath.section][indexPath.row][@"controller"]){
        UIViewController *vc = [[self.dataList[indexPath.section][indexPath.row][@"controller"] alloc] init];
        
        vc.title = self.dataList[indexPath.section][indexPath.row][@"title"];
        
        vc.view.backgroundColor = Color(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
        
        
        [self.navigationController pushViewController:vc animated:YES];
        self.navigationController.navigationBar.hidden = NO;
    }else{
        
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDWebImageManager sharedManager] cancelAll];
        
        cell.detailTextLabel.text = [self caCheSize];
    }

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y < 0) {
        [self.headerView startWave];
        self.headerView.frame = CGRectMake(scrollView.contentOffset.y / 2, scrollView.contentOffset.y , ScreenW - scrollView.contentOffset.y , 270 - scrollView.contentOffset.y);
    }

}
@end
