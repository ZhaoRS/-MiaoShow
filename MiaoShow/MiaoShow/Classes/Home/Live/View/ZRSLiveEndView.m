//
//  ZRSLiveEndView.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/18.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSLiveEndView.h"

@interface ZRSLiveEndView ()
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookOtherBtn;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;

@end

@implementation ZRSLiveEndView


+ (instancetype)liveEndView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self maskRadids:self.quitBtn];
    [self maskRadids:self.careBtn];
    [self maskRadids:self.lookOtherBtn];
}


- (void)maskRadids:(UIButton *)btn {
    btn.layer.cornerRadius = btn.height * 0.5;
    btn.layer.masksToBounds = YES;
    if (btn != self.careBtn) {
        btn.layer.borderColor = KeyColor.CGColor;
        btn.layer.borderWidth = 1;
    }
}

- (IBAction)care:(UIButton *)sender {
    [sender setTitle:@"关注成功" forState:UIControlStateNormal];
}
- (IBAction)lookOther {
    [self removeFromSuperview];
    if (self.lookOtherBlock) {
        self.lookOtherBlock();
    }
}
- (IBAction)quit {
    if (self.quitBlock) {
        self.quitBlock();
    }
}


@end
