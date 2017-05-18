//
//  ZRSLiveCollectionViewController.h
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/18.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRSLiveItem;

@interface ZRSLiveCollectionViewController : UICollectionViewController

/**直播*/
@property (nonatomic, strong) NSArray *lives;
/**当前的index*/
@property (nonatomic, assign) NSUInteger currentIndex;

@end
