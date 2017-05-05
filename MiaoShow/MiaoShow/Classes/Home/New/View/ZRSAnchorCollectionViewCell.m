//
//  ZRSAnchorCollectionViewCell.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/5.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSAnchorCollectionViewCell.h"
#import "ZRSUserItem.h"
#import <UIImageView+WebCache.h>


@interface ZRSAnchorCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;


@end

@implementation ZRSAnchorCollectionViewCell

- (void)setUser:(ZRSUserItem *)user {
    _user = user;
    //设置封面头像
    [_coverView sd_setImageWithURL:[NSURL URLWithString:user.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    //是否是新主播
    self.star.hidden = !user.newStar;
    //地址
    [self.locationBtn setTitle:user.position forState:UIControlStateNormal];
    //主播名
    self.nickNameLabel.text = user.nickname;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
