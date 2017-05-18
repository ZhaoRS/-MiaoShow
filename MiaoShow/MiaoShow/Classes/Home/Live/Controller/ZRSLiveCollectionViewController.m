//
//  ZRSLiveCollectionViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/18.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSLiveCollectionViewController.h"
#import "ZRSLiveItem.h"
#import "ZRSLiveViewCell.h"
#import "ZRSRefreshGifHeader.h"
#import "ZRSLiveFlowLayout.h"
#import "ZRSUserView.h"

@interface ZRSLiveCollectionViewController ()
/**用户信息*/
@property (nonatomic, weak) ZRSUserView *userView;

@end

@implementation ZRSLiveCollectionViewController

static NSString * const reuseIdentifier = @"ZRSLiveViewCell";

- (instancetype)init {
    return [super initWithCollectionViewLayout:[[ZRSLiveFlowLayout alloc] init]];
}

- (ZRSUserView *)userView {
    if (!_userView) {
        ZRSUserView *userView = [ZRSUserView userView];
        [self.collectionView addSubview:userView];
        _userView = userView;
        
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(ScreenHeight));
        }];
        
        userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [userView setCloseBlock:^{
           [UIView animateWithDuration:0.5 animations:^{
               self.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
           } completion:^(BOOL finished) {
               [self.userView removeFromSuperview];
               self.userView = nil;
           }];
        }];
    }
    return _userView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ZRSLiveViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    ZRSRefreshGifHeader *header = [ZRSRefreshGifHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
        self.currentIndex ++;
        if (self.currentIndex == self.lives.count) {
            self.currentIndex = 0;
        }
        [self.collectionView reloadData];
    }];
    
    header.stateLabel.hidden = NO;
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStateIdle];
    self.collectionView.mj_header = header;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotifyClickUser object:nil];
    
    
}


- (void)clickUser:(NSNotification *)notify {

    if (notify.userInfo[@"user"] != nil) {
        ZRSUserItem *user = notify.userInfo[@"user"];
        self.userView.user = user;
        [UIView animateWithDuration:0.5 animations:^{
            self.userView.transform = CGAffineTransformIdentity;
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZRSLiveViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.parentVc = self;
    cell.live = self.lives[self.currentIndex];
    NSUInteger relateIndex = self.currentIndex;
    if (self.currentIndex + 1 == self.lives.count) {
        relateIndex = 0;
    } else {
        relateIndex += 1;
    }
    cell.relateLive = self.lives[relateIndex];
    [cell setClickRelatedLive:^{
        self.currentIndex += 1;
        [self.collectionView reloadData];
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
