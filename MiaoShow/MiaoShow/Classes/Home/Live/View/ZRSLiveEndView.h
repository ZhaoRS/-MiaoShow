//
//  ZRSLiveEndView.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/18.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRSLiveEndView : UIView

+ (instancetype)liveEndView;
/**查看其他主播*/
@property (nonatomic, copy) void (^lookOtherBlock)();
/**退出*/
@property (nonatomic, copy) void (^quitBlock)();

@end
