//
//  ZRSLiveAnchorView.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/4/7.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSLiveAnchorView.h"
#import "ZRSUserItem.h"
#import "ZRSLiveItem.h"
#import "UIImage+ZRSExtension.h"
#import <UIImageView+WebCache.h>

@interface ZRSLiveAnchorView ()
@property (weak, nonatomic) IBOutlet UIView *anchorView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *peoplesScrollView;
@property (weak, nonatomic) IBOutlet UIButton *giftView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *chaoYangUsers;

@end

@implementation ZRSLiveAnchorView


+ (instancetype)liveAnchorView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self maskViewToBounds:self.anchorView];
    [self maskViewToBounds:self.headImageView];
    [self maskViewToBounds:self.careBtn];
    [self maskViewToBounds:self.giftView];
    
    self.headImageView.layer.borderWidth = 1;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.careBtn setBackgroundImage:[UIImage imageWithColor:KeyColor size:self.careBtn.size] forState:UIControlStateNormal];
    [self.careBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:self.careBtn.size] forState:UIControlStateSelected];
    
    
}


- (void)maskViewToBounds:(UIView *)view {
    view.layer.cornerRadius = view.height * 0.5;
    view.layer.masksToBounds = YES;
}

static int randomNum = 0;

- (void)setLive:(ZRSLiveItem *)live {
    _live = live;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:live.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    self.nameLabel.text = live.myname;
    self.peopleLabel.text = [NSString stringWithFormat:@"%ld人", live.allnum];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateNum) userInfo:nil repeats:YES];
    [self.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChangYang:)]];
}

- (void)updateNum
{
    randomNum += arc4random_uniform(5);
    self.peopleLabel.text = [NSString stringWithFormat:@"%ld人", self.live.allnum + randomNum];
    [self.giftView setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u", 1993045 + randomNum,  124593+randomNum] forState:UIControlStateNormal];
}




- (void)setupChangeyang {
    self.peoplesScrollView.contentSize = CGSizeMake((self.peoplesScrollView.height + DefaultMargin) * self.chaoYangUsers.count + DefaultMargin, 0);
    CGFloat width = self.peoplesScrollView.height - 10;
    CGFloat x = 0;
    for (int i = 0; i < self.chaoYangUsers.count; i ++) {
        x = 0 + (DefaultMargin + width) * i;
        UIImageView *userView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 5, width, width)];
        userView.layer.cornerRadius = width * 0.5;
        userView.layer.masksToBounds = YES;
        ZRSUserItem *user = self.chaoYangUsers[i];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
           dispatch_async(dispatch_get_main_queue(), ^{
               userView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
           });
        }];
        
        //设置监听
        userView.userInteractionEnabled = YES;
        [userView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickChangYang:)]];
        userView.tag = i;
        [self.peoplesScrollView addSubview:userView];
        
    }
}


- (void)clickChangYang:(UITapGestureRecognizer *)tapGes {
    if (tapGes.view == self.headImageView) {
        ZRSUserItem *user = [[ZRSUserItem alloc] init];
        user.nickname = self.live.myname;
        user.photo = self.live.bigpic;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : user}];
        
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : self.chaoYangUsers[tapGes.view.tag]}];
    }
}




- (IBAction)Device:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.clickDeviceShow) {
        self.clickDeviceShow(sender.selected);
    }
}



#pragma mark - set get
- (NSArray *)chaoYangUsers {
    if (!_chaoYangUsers) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user.plist" ofType:nil]];
        _chaoYangUsers = [ZRSUserItem mj_objectArrayWithKeyValuesArray:array];
    }
    return _chaoYangUsers;
}

@end
