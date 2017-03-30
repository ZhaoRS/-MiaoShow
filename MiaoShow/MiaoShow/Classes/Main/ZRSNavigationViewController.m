//
//  ZRSNavigationViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/29.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSNavigationViewController.h"

@interface ZRSNavigationViewController ()

@end

@implementation ZRSNavigationViewController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {//隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义返回按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        //如果自定义返回按钮后 ，华东范桂失效，添加
        __weak typeof(viewController)weakSelf = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    //判断两种情况 push和present
    if ((self.presentationController || self.presentationController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self popViewControllerAnimated:YES];
    }
}
@end
