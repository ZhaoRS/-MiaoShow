//
//  ZRSBottomToolView.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/4/7.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LiveToolType) {
    LiveToolTypePublicTalk,
    LiveToolTypePrivateTalk,
    LiveToolTypeGift,
    LiveToolTypeRank,
    LiveToolTypeShare,
    LiveToolTypeClose
};

@interface ZRSBottomToolView : UIView

/** 点击工具栏  */
@property (nonatomic, copy) void (^clickToolBlock)(LiveToolType type) ;

@end
