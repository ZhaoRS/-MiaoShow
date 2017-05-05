//
//  ZRSNewFlowLayout.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/5.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSNewFlowLayout.h"

@implementation ZRSNewFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat wh = (ScreenWidth - 3) / 3.0;
    self.itemSize = CGSizeMake(wh, wh);
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
}

@end
