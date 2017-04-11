//
//  SCXBaseTableViewController.m
//   
//
//  Created by 孙承秀 on 16/9/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewController.h"

#import <objc/runtime.h>
const char *SCXBaseTableViewLeftHandleKey;
const char *SCXBaseTableViewRightHandleKey;
@interface SCXBaseTableViewController ()

@end

@implementation SCXBaseTableViewController
#pragma mark --
-(void)setNeedCellSepLine:(BOOL)needCellSepLine{
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   // self.tableView.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight-40-64);
    self.tableView.frame=self.view.bounds;
    
    [self.view addSubview:self.tableView];
}
#pragma mark--懒加载
-(SCXBaseTableView *)tableView{
    if (!_tableView) {
        SCXBaseTableView *tab = [[SCXBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView = tab;
        tab.dataSource = self;
        tab.delegate = self;
        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        
    }
    return _tableView;
    
}
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}
#pragma maek--设置刷新的种类
/**
 *  设置刷新的种类
 *
 *  @param refreshType 刷新种类
 */
-(void)setRefreshType:(SCXREefreshType)refreshType{
    _refreshType=refreshType;
    switch (refreshType) {
        case SCXREefreshTypeNone:
            break;
            case SCXREefreshTypeOblyDownRefresh:
            [self SCX_addDownRefresh];
            break;
            case SCXREefreshTypeOnlyUpRefresh:
            [self SCX_addUpRefresh];
            break;
            case SCXREefreshTypeRefresh:
            [self SCX_addDownRefresh];
            [self SCX_addUpRefresh];
            break;
            
        default:
            break;
    }

}
#pragma mark --  添加下拉刷新
-(void)SCX_addDownRefresh{
    [SCXUtil SCX_addDownGIFRefreshWithScrollView:self.tableView andCallBackBlock:^{
        [self SCX_beginDownRefresh];
    }];
}

- (void)SCX_addUpRefresh{
    [SCXUtil SCX_addUpRefreshWithScrollView:self.tableView andCallBackBlock:^{
        [self SCX_beginUpRefresh];
    }];

}

#pragma mark--下拉刷新实现
-(void)SCX_beginDownRefresh{
    if (self.refreshType==SCXREefreshTypeNone||self.refreshType==SCXREefreshTypeOnlyUpRefresh) {
        return;
    }
    self.isDownRefresh=YES;
    self.isUpRefresh=NO;
    NSLog(@"开始下拉刷新了");
    [self SCX_loadData];
    
}

/**
 从网络获取数据刷新列表
 */
- (void)SCX_loadData{

}
#pragma mark--上拉刷新实现
-(void)SCX_beginUpRefresh{
    if (self.refreshType==SCXREefreshTypeOblyDownRefresh||self.refreshType==SCXREefreshTypeNone) {
        return;
    }
    self.isUpRefresh=YES;
    self.isDownRefresh=NO;
    NSLog(@"开始以上上拉刷新了");
}
#pragma mark--刷新数据
-(void)SCX_reloadData{
    [self.tableView reloadData];
}

/**
 停止刷新动画
 */
- (void)SCX_endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

}
#pragma mark--设置导航栏左右按钮
-(void)SCX_setLeftNavigationItemWithTitle:(NSString *)title handle:(void (^)(NSString *))handle{

    [self SCX_setNavigitionItemWithTitle:title handel:handle isLeftItem:YES ];
}
-(void)SCX_setRightNavigationItemWithTitle:(NSString *)title handle:(void (^)(NSString *))handle{
    [self SCX_setNavigitionItemWithTitle:title handel:handle isLeftItem:NO];
    
}
-(void)SCX_setNavigitionItemWithTitle:(NSString *)title handel:(void (^)(NSString *))handle isLeftItem:(BOOL)isLeftItem{
    if (title.length==0||!handle    ) {
        if (title.length==0) {
            title=@"";
        }
        if ([title isKindOfClass:[NSNull class]]||title==nil) {
            title=@"";
        }
        if (isLeftItem) {
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
        }
        else self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    else{
        if (isLeftItem) {
            objc_setAssociatedObject(self, SCXBaseTableViewLeftHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(SCX_navigationItemClick:)];
        }
        else{
            objc_setAssociatedObject(self, SCXBaseTableViewRightHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(SCX_navigationItemClick:)];
        }
       
        
    }

}
-(void)SCX_navigationItemClick:(UIBarButtonItem *)button{
    void(^handle)(NSString *)= objc_getAssociatedObject(self, SCXBaseTableViewRightHandleKey);
    if (handle) {
        handle(button.title );
    }
}
#pragma mark--tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(SCX_numberOfSectionsInTableView:)]) {
        return [self SCX_numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(SCX_tableViewNumberOfRowsInSection:)]) {
        return [self SCX_tableViewNumberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(SCX_tableViewCellForRowAtIndexPath:)]) {
        return [self SCX_tableViewCellForRowAtIndexPath:indexPath];
    }
    SCXBaseTableViewCell *cell=[SCXBaseTableViewCell cellWithTableView:tableView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(SCX_tableViewHeightForRowAtIndexPath:)]) {
        return [self SCX_tableViewHeightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXBaseTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self respondsToSelector:@selector(SCX_tableViewDidSelectRowAtIndexPath:withCell:)]) {
        [self SCX_tableViewDidSelectRowAtIndexPath:indexPath withCell:cell];
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewViewForHeaderInSection:)]) {
        return [self SCX_tableViewViewForHeaderInSection:section];
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewViewForFooterInSection:)]) {
        return [self SCX_tableViewViewForHeaderInSection:section];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewHeightForHeaderInSection:)]) {
        return [self SCX_tableViewHeightForHeaderInSection:section];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewHeightForFooterInSection:)]) {
        return [self SCX_tableViewHeightForFooterInSection:section];
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(SCX_tableViewWillDisplayCell:forRowAtIndexPath:)]) {
        return [self SCX_tableViewWillDisplayCell:cell forRowAtIndexPath:indexPath];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
