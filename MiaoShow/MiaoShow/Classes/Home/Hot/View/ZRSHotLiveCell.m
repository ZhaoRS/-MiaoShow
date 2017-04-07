//
//  ZRSHotLiveCell.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/30.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSHotLiveCell.h"
#import "ZRSLiveItem.h"
#import "UIImage+ZRSExtension.h"
#import <UIImageView+WebCache.h>

@interface ZRSHotLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *startView;
@property (weak, nonatomic) IBOutlet UILabel *chaoyangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgPicView;



@end

@implementation ZRSHotLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setLive:(ZRSLiveItem *)live {
    _live = live;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:live.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage circleImage:image borderColor:[UIColor redColor]borderWidth:1];
        self.headImageView.image = image;
    }];
    
    self.nameLabel.text = live.myname;
    //如果没有地址，给个默认地址
    if (!live.gps.length) {
        live.gps = @"喵星";
    }
    
    [self.locationBtn setTitle:live.gps forState:UIControlStateNormal];
    [self.bgPicView sd_setImageWithURL:[NSURL URLWithString:live.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    self.startView.image = live.starImage;
    self.startView.hidden = !live.starlevel;
    
    //设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%ld人在看", (unsigned long)live.allnum];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%ld", live.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range];
    [attr addAttribute:NSForegroundColorAttributeName value:KeyColor range:range];
    self.chaoyangLabel.attributedText = attr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
