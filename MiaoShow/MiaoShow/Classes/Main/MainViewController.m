//
//  MainViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/29.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "MainViewController.h"
#import "UIDevice+SELExtension.h"
#import <AVFoundation/AVFoundation.h>
#import "ZRSNavigationViewController.h"
#import "HomeViewController.h"
#import "ShowTimeViewController.h"
#import "ProfileViewController.h"

@interface MainViewController () <UITabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setup];
    
}
- (void)setup {
    [self addChildViewController:[[HomeViewController alloc] init] imageNamed:@"toolbar_home"];
    UIViewController *showTime = [[UIViewController alloc] init];
    showTime.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:showTime imageNamed:@"toolbar_live"];
    [self addChildViewController:[[ProfileViewController alloc] init] imageNamed:@"toolbar_me"];
}

- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName {
    ZRSNavigationViewController *nav = [[ZRSNavigationViewController alloc] initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", imageName]];
    //设置图片居中
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置导航栏为透明的
    //    if ([childController isKindOfClass:[ProfileController class]]) {
    //        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //        nav.navigationBar.shadowImage = [[UIImage alloc] init];
    //        nav.navigationBar.translucent = YES;
    //    }
    [self addChildViewController:nav];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count - 2) {
        //判断是否是模拟器
        if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
            [self showInfo:@"请在真机进行测试， 此模块不支持模拟器测试"];
            return NO;
        }
        
        //判断是否有摄像头
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showInfo:@"您的设备没有涉嫌头或者相关的驱动,不能进行直播"];
            return NO;
        }
        
        //判断是否有摄像头权限
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusRestricted || authorizationStatus == AVAuthorizationStatusDenied) {
            [self showInfo:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
            return NO;
        }
        
        //开启麦克风权限
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    return YES;
                } else {
                    [self showInfo:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                    return NO;
                }
            }];
        }
        
        
    }
    
    
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
