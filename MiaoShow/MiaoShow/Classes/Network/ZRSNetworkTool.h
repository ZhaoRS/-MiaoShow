//
//  ZRSNetworkTool.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/28.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, //没有网络
    NetworkStates2G, //2g
    NetworkStates3G, //3g
    NetworkStates4G, //4G
    NetworkStatesWIFI //WIFI
};

@interface ZRSNetworkTool : AFHTTPSessionManager
+ (instancetype) shareTool;

//判断网络类型
+ (NetworkStates)getNetworkStates;

@end
