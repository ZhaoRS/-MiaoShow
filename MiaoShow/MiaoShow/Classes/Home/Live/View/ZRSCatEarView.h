//
//  ZRSCatEarView.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/17.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZRSLiveItem;

@interface ZRSCatEarView : UIView


/** 主播 */
@property (nonatomic, strong) ZRSLiveItem *live;
+ (instancetype)catEarView;

@end
