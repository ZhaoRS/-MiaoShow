//
//  SLTopWindow.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/28.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "SLTopWindow.h"
#import <UIKit/UIKit.h>

@implementation SLTopWindow
static UIButton *btn_;
+ (void)initialize {
    UIButton *btn = [[UIButton alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
    [btn addTarget:self action:@selector(windowClick) forControlEvents:UIControlEventTouchUpInside];
    [[self statusBarView] addSubview:btn];
    btn.hidden = YES;
    btn_ = btn;
}

+ (void)show {
    btn_.hidden = NO;
}
+ (void)hide {
    btn_.hidden = YES;
}


/**
 获取当前状态栏的方法
 */
+ (UIView *)statusBarView {
    UIView *statusBar = nil;
    NSData *data = [NSData dataWithBytes:(unsigned char[]){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    id object = [UIApplication sharedApplication];
    if ([object respondsToSelector:NSSelectorFromString(key)]) {
        statusBar = [object valueForKey:key];
    }
    return statusBar;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick {
    NSLog(@"点击了最顶部...");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
    
}
+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subView in superview.subviews) {
        // 如果是scrollview，滚动到最顶部
        if ([subView isKindOfClass:[UIScrollView class]] && subView.isShowingOnKeyWindow) {
            CGPoint offset = subView.contentOffset;
            offset.y = - subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        //继续查找子控件
        [self searchScrollViewInView:superview];
    }
}

@end
