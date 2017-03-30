//
//  ThirdLoginView.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/27.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeSina,
    LoginTypeQQ,
    LoginTypeWechat,
};


@interface ThirdLoginView : UIView
/**点击按钮*/
@property (nonatomic, copy) void (^clickLogin) (LoginType type);

@end
