//
//  HomeViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/29.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "HomeViewController.h"
#import "ZRSSelectedView.h"
#import "ZRSHotViewController.h"
#import "ZRSNewStarViewController.h"
#import "ZRSCareViewController.h"

@interface HomeViewController () <UIScrollViewDelegate>
/** 顶部选择视图 */
@property (nonatomic, assign) ZRSSelectedView *selectedView;
/** UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 热播 */
@property (nonatomic, weak) ZRSHotViewController *hotVc;
/** 最新主播 */
@property (nonatomic, weak) ZRSNewStarViewController *starVc;
@property (nonatomic, weak) ZRSCareViewController *careVc;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
}

- (void)setup {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:nil action:nil];
    [self setupTopMenu];
}

- (void)loadView {
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    view.backgroundColor = [UIColor whiteColor];
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.pagingEnabled = YES;
    view.delegate = self;
    view.bounces = NO;
    
    CGFloat height = ScreenHeight - 49;
    
    ZRSHotViewController *hot = [[ZRSHotViewController alloc] init];
    hot.view.frame = [UIScreen mainScreen].bounds;
    hot.view.height = height;
    [self addChildViewController:hot];
    [view addSubview:hot.view];
    _hotVc = hot;
    
    
    ZRSNewStarViewController *newStar = [[ZRSNewStarViewController alloc] init];
    newStar.view.frame = [UIScreen mainScreen].bounds;
    newStar.view.x = ScreenWidth;
    newStar.view.height = height;
    [self addChildViewController:newStar];
    [view addSubview:newStar.view];
    _starVc = newStar;
    
    ZRSCareViewController *careVc = [[ZRSCareViewController alloc] initWithNibName:@"ZRSCareViewController" bundle:nil];
    careVc.view.frame = [UIScreen mainScreen].bounds;
    careVc.view.x = ScreenWidth * 2;
    careVc.view.height = height;
    [self addChildViewController:careVc];
    [view addSubview:careVc.view];
    _careVc = careVc;
    
    self.view = view;
    self.scrollView = view;
}

- (void)setupTopMenu {
    ZRSSelectedView *selectedView = [[ZRSSelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    selectedView.x = 45;
    selectedView.width = ScreenWidth - 45 * 2;
    [selectedView setSelectedBlock:^(HomeType type) {
        [self.scrollView setContentOffset:CGPointMake(type * ScreenWidth, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:selectedView];
    _selectedView = selectedView;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / ScreenWidth;
    CGFloat offsetX = scrollView.contentOffset.x / ScreenWidth * (self.selectedView.width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    self.selectedView.underLine.x = 15 + offsetX;
    if (page == 1 ) {
        self.selectedView.underLine.x = offsetX + 10;
    }else if (page > 1){
        self.selectedView.underLine.x = offsetX + 5;
    }
    self.selectedView.selectedType = (int)(page + 0.5);
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
