//
//  ZRSSelectedView.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/29.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HomeType) {
    HomeTypeHot, // 热门
    HomeTypeNew, //最新
    HomeTypeCare, //关注
};

@interface ZRSSelectedView : UIView

/**  选中了*/
@property (nonatomic, copy) void (^selectedBlock)(HomeType type);
/** 下划线 */
@property (nonatomic, weak, readonly) UIView *underLine;
/** 设置滑动选中的按钮 */
@property (nonatomic, assign) HomeType selectedType;

@end
