//
//  ZRSUserItem.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/30.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSUserItem.h"
#import <MJExtension/MJExtension.h>

@implementation ZRSUserItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"newStar":@"new"};
}

@end
