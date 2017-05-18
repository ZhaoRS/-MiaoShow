//
//  ZRSUserView.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/18.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRSUserItem;

@interface ZRSUserView : UIView
+ (instancetype)userView;
/**点击关闭*/
@property (nonatomic, copy) void(^closeBlock)();
/**用户信息*/
@property (nonatomic, strong) ZRSUserItem *user;

@end
