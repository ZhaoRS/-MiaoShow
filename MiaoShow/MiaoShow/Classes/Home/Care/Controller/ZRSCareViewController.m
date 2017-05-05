//
//  ZRSCareViewController.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/5.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSCareViewController.h"

@interface ZRSCareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toSeeBtn;

@end

@implementation ZRSCareViewController
- (IBAction)toSeeBtnAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyToseeBigWorld object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.toSeeBtn.layer.borderWidth = 1;
    self.toSeeBtn.layer.borderColor = KeyColor.CGColor;
    self.toSeeBtn.layer.cornerRadius = self.toSeeBtn.height * 0.5;
    [self.toSeeBtn.layer masksToBounds];
    
    [self.toSeeBtn setTitleColor:KeyColor forState:UIControlStateNormal];
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
