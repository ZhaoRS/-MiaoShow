//
//  ZRSLiveViewCell.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/17.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRSLiveItem, ZRSUserItem;
@interface ZRSLiveViewCell : UICollectionViewCell
/** 直播 */
@property (nonatomic, strong) ZRSLiveItem *live;
/** 相关的直播或者主播 */
@property (nonatomic, strong) ZRSLiveItem *relateLive;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentVc;
/** 点击关联主播 */
@property (nonatomic, copy) void (^clickRelatedLive)();
@end
