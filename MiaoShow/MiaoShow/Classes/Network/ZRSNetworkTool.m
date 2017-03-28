//
//  ZRSNetworkTool.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/3/28.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSNetworkTool.h"

@implementation ZRSNetworkTool

static ZRSNetworkTool *_manager;
- (instancetype)shareTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [ZRSNetworkTool manager];
        //设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}

//判断网络类型
+ (NetworkStates)getNetworkStates {
    NSArray *subViews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    //保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subViews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                    states = NetworkStatesWIFI;
                    break;
                    
                default:
                    break;
            }
        }
    }
    return states;
}

@end
