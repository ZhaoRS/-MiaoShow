//
//  UIImageView+ZRSGif.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/28.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "UIImageView+ZRSGif.h"

@implementation UIImageView (ZRSGif)

//播放GIF
- (void)playGifAnim:(NSArray *)images {
    if (!images.count) {
        return;
    }
    
    //动画图片数组
    self.animationImages = images;
    //执行一次完整的动画所需要的时间
    self.animationDuration = 0.5;
    //设置动画重复次数，0 就是无限循环
    self.animationRepeatCount = 0;
    [self startAnimating];
}

//停止动画
- (void)stopGifAnim {
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}

@end
