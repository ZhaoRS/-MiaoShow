//
//  HomeViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/29.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "HomeViewController.h"
#import "ZRSSelectedView.h"

@interface HomeViewController () <UIScrollViewDelegate>
/** 顶部选择视图 */
@property (nonatomic, assign) ZRSSelectedView *selectedView;
/** UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 热播 */

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end