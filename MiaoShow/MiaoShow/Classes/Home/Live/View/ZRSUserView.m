//
//  ZRSUserView.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/18.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSUserView.h"
#import "ZRSUserItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+ZRSExtension.h"

@interface ZRSUserView ()

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *careNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;
@property (weak, nonatomic) IBOutlet UIView *userView;

@end

@implementation ZRSUserView
+ (instancetype)userView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.careNumLabel.text = [NSString stringWithFormat:@"%d", arc4random_uniform(5000) + 500];
    self.fansNumLabel.text = [NSString stringWithFormat:@"%d", arc4random_uniform(3000) + 500];
    self.userView.layer.cornerRadius = 10;
    self.userView.layer.masksToBounds = YES;
}

- (void)setUser:(ZRSUserItem *)user {
    _user = user;
    self.nickNameLabel.text = user.nickname;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        self.coverView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
    }];
}

- (IBAction)care:(UIButton *)sender {
}

- (IBAction)tipoffs {
    [self showInfo:@"举报成功"];
}

- (IBAction)close {
    if (self.closeBlock) {
        self.closeBlock();
    }
}


@end
