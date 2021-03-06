//
//  ZRSBottomToolView.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/4/7.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSBottomToolView.h"

@implementation ZRSBottomToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (NSArray *)tools {
    return @[@"talk_public_40x40", @"talk_private_40x40", @"talk_sendgift_40x40", @"talk_rank_40x40", @"talk_share_40x40", @"talk_close_40x40"];
}

- (void)setup {
    CGFloat wh = 40;
    CGFloat margin = (ScreenWidth - wh * self.tools.count) / (self.tools.count + 1.0);
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < self.tools.count; i ++) {
        x = margin + (margin + wh) * i;
        UIImageView *toolView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        toolView.userInteractionEnabled = YES;
        toolView.tag = i;
        toolView.image = [UIImage imageNamed:self.tools[i]];
        [toolView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
        [self addSubview:toolView];
    }
}

- (void)click:(UITapGestureRecognizer *)tapRec {
    if (self.clickToolBlock) {
        self.clickToolBlock(tapRec.view.tag);
    }
}

@end
