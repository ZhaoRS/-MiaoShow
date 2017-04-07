//
//  ZRSHomeADCell.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/30.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSHomeADCell.h"
#import "ZRSTopAD.h"

@implementation ZRSHomeADCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTopADs:(NSArray *)topADs {
    _topADs = topADs;
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (ZRSTopAD *topAD in topADs) {
        [imageUrls addObject:topAD.imageUrl];
    }
    ZRSCarouselView *view = [ZRSCarouselView carouselViewWithImageArray:imageUrls describeArray:nil];
    view.time = 2.0;
    view.delegate = self;
    view.changeMode = PageChangeModeFade;
    view.frame = self.contentView.bounds;
    [self.contentView addSubview:view];
}

#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(ZRSCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    if (self.imageClickBlock) {
        self.imageClickBlock(self.topADs[index]);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
