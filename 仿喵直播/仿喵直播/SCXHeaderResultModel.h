//
//  SCXHeaderResultModel.h
//  仿喵直播
//
//  Created by 孙承秀 on 2017/3/25.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCXHeaderResultModel : NSObject
/** 新增时间 */
@property (nonatomic, copy  ) NSString   *addTime;
/** 大图 */
@property (nonatomic, copy  ) NSString   *bigpic;
/** 直播流 */
@property (nonatomic, copy  ) NSString   *flv;
/** 所在城市 */
@property (nonatomic, copy  ) NSString   *gps;
/** 不知道什么鬼 */
@property (nonatomic, copy  ) NSString   *hiddenVer;
/** AD图片 */
@property (nonatomic, copy  ) NSString   *imageUrl;
/** 链接 */
@property (nonatomic, copy  ) NSString   *link;
/** 不知道什么鬼 */
@property (nonatomic, copy  ) NSString   *lrCurrent;
/** 主播名 */
@property (nonatomic, copy  ) NSString   *myname;
/** 个性签名 */
@property (nonatomic, copy  ) NSString   *signatures;
/** 主播头像 */
@property (nonatomic, copy  ) NSString   *smallpic;
/** AD名 */
@property (nonatomic, copy  ) NSString   *title;
/** 主播ID */
@property (nonatomic, copy  ) NSString   *useridx;
/** 当前状态 */
@property (nonatomic, assign) NSUInteger state;
/** 倒计时 */
@property (nonatomic, assign) NSUInteger cutTime;
/** AD序号 */
@property (nonatomic, assign) NSUInteger orderid;
/** 房间号 */
@property (nonatomic, assign) NSUInteger roomid;
/** 所在服务器号 */
@property (nonatomic, assign) NSUInteger serverid;
@end
