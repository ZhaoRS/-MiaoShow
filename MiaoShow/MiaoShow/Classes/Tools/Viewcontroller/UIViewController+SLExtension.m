//
//  UIViewController+SLExtension.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/28.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "UIViewController+SLExtension.h"
#import "UIImageView+ZRSGif.h"
#import <objc/message.h>

static const void *GifKey = &GifKey;
@implementation UIViewController (SLExtension)
- (UIImageView *)gifView {
    return objc_getAssociatedObject(self, GifKey);
}

- (void)setGifView:(UIImageView *)gifView {
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 显示GIF加载动画
- (void)showGifLoading:(NSArray *)images inView:(UIView *)view {
    if (!images.count) {
        images = @[[UIImage imageNamed:@"hold1_60x72"], [UIImage imageNamed:@"hold2_60x72"], [UIImage imageNamed:@"hold3_60x72"]];
    }
    
    UIImageView *gifView = [[UIImageView alloc] init];
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@70);
    }];
    self.gifView = gifView;
    [gifView playGifAnim:images];
}

//取消GIF加载动画
- (void)hideGifLoding {
    [self.gifView stopGifAnim];
    self.gifView = nil;
}

- (BOOL)isNotEmpty:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return YES;
    }
    return NO;
}




@end
