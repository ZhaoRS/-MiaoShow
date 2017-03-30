//
//  ZRSHomeADCell.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/30.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRSTopAD;

@interface ZRSHomeADCell : UITableViewCell
/** 顶部AD数组 */
@property (nonatomic, strong) NSArray *topADs;
/** 点击图片的block */
@property (nonatomic, copy) void (^imageClickBlock)(ZRSTopAD *topAD);
@end
