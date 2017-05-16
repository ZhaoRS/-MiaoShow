//
//  ZRSLiveAnchorView.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/4/7.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRSLiveItem;
@class ZRSUserItem;

@interface ZRSLiveAnchorView : UIView

+ (instancetype)liveAnchorView;

/** 主播 */
@property(nonatomic, strong) ZRSUserItem *user;
/** 直播 */
@property(nonatomic, strong) ZRSLiveItem *live;
/** 点击开关  */
@property(nonatomic, copy)void (^clickDeviceShow)(bool selected);

@end
