//
//  NSSafeObject.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/4/7.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "NSSafeObject.h"

@interface NSSafeObject ()
{
    __weak id _object;
    SEL _sel;
}

@end

@implementation NSSafeObject

- (instancetype)initWithObject:(id)object {
    if (self = [super init]) {
        _object = object;
        _sel = nil;
    }
    return self;
}

- (instancetype)initWithObject:(id)object withSelector:(SEL)selector {
    if (self = [super init]) {
        _object = object;
        _sel = selector;
    }
    return self;
}

- (void)excute {
    if (_object && _sel && [_object respondsToSelector:_sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_object performSelector:_sel withObject:nil];
#pragma clang diagnostic pop
    }
}

@end
