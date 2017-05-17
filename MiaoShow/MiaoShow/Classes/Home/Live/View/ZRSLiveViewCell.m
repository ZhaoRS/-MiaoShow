//
//  ZRSLiveViewCell.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/17.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSLiveViewCell.h"
#import "ZRSLiveItem.h"
#import "ZRSUserItem.h"
#import "UIImage+ZRSExtension.h"
#import "ZRSBottomToolView.h"
#import "ZRSLiveAnchorView.h"
#import "NSSafeObject.h"
#import <SDWebImageDownloader.h>
#import <BarrageRenderer.h>
#import "ZRSCatEarView.h"

@interface ZRSLiveViewCell ()
{
    BarrageRenderer *_renderer;
    NSTimer *_timer;
}
/** 直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/** 底部的工具栏 */
@property(nonatomic, weak) ZRSBottomToolView *toolView;
/** 顶部主播相关视图 */
@property(nonatomic, weak) ZRSLiveAnchorView *anchorView;
/** 同类型直播视图 */
@property(nonatomic, weak) ZRSCatEarView *catEarView;
/** 同一个工会的主播/相关主播 */
@property(nonatomic, weak) UIImageView *otherView;
/** 直播开始前的占位图片 */
@property(nonatomic, weak) UIImageView *placeHolderView;
/** 粒子动画 */
@property(nonatomic, weak) CAEmitterLayer *emitterLayer;
/** 直播结束的界面 */
//@property (nonatomic, weak) ALinLiveEndView *endView;
@end

@implementation ZRSLiveViewCell

- (void)quit {
    if (_catEarView) {
        [_catEarView removeFromSuperview];
        _catEarView = nil;
    }
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [_renderer stop];
    [_renderer.view removeFromSuperview];
    _renderer = nil;
    [self.parentVc dismissViewControllerAnimated:YES completion:nil];
}

- (void)autoSendBarrage {
    NSInteger spriteNumber = [_renderer spritesNumberWithName:nil];
    if (spriteNumber <= 50) {//限制屏幕上的弹幕量
//        [_renderer receive:[self w]]
    }
}

- (void)exeute {
    
}

- (void)initObserver {
    //监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinsh) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}
- (void)didFinsh {
    NSLog(@"加载状态/....%ld, %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    //因为网速问题或者其他的原因导致直播stop了  也要现实gif
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.parentVc.gifView) {
        [self.parentVc showGifLoading:nil inView:self.moviePlayer.view];
        return;
    }
    /*
        方法
     1、重新获取直播地址， 服务端控制是否有地址返回
     2、用户http请求地址，若请求成功则表示直播未结束， 否则结束
     */
    __weak typeof(self)weakSelf = self;
    [[ZRSNetworkTool shareTool] GET:self.live.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功%@，等待继续播放", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
        [self.moviePlayer shutdown];
        [self.moviePlayer.view removeFromSuperview];
        self.moviePlayer = nil;
//        self.endView.hidden = NO;
    }];
}

- (void)stateDidChange {
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0)  {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeHolderView) {
                    [_placeHolderView removeFromSuperview];
                    _placeHolderView = nil;
                    [self.moviePlayer.view addSubview:_renderer.view];
                }
                [self.parentVc hideGifLoding];
            });
        } else {
            //如果网络状况不好， 断开后回复， 也需要去掉加载
            if (self.parentVc.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.parentVc hideGifLoding];
                });
            }
        }
    } else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled) {//网速不佳 自动暂停状态
        [self.parentVc showGifLoading:nil inView:self.moviePlayer.view];
    
    }
}

#pragma mark - 弹幕描述方法
long _index = 0;
///生成精灵描述 - 过程文字描述
//- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(NSInteger)direction {
//    BarrageDescriptor *descriptor = [[BarrageDescriptor alloc] init];
//    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
//    
//}


#pragma mark -set get
- (UIImageView *)placeHolderView {
    if (!_placeHolderView) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.contentView.bounds;
        imageView.image = [UIImage imageNamed:@"profile_user_414x414"];
        [self.contentView addSubview:imageView];
        _placeHolderView = imageView;
        [self.parentVc showGifLoading:nil inView:self.placeHolderView];
    }
    return _placeHolderView;
}

BOOL _isSelected = NO;
- (ZRSBottomToolView *)toolView {
    if (!_toolView) {
        ZRSBottomToolView *tooView = [[ZRSBottomToolView alloc] init];
        [tooView setClickToolBlock:^(LiveToolType type){
            switch (type) {
                case LiveToolTypePublicTalk:
                    _isSelected = !_isSelected;
                    _isSelected ?  [_renderer start] : [_renderer stop];
                    break;
                case LiveToolTypePrivateTalk:
                    
                    break;
                case LiveToolTypeGift:
                    
                    break;
                case LiveToolTypeRank:
                    
                    break;
                case LiveToolTypeShare:
                    
                    break;
                case LiveToolTypeClose:
                    [self quit];
                    break;

                default:
                    break;
            }
        }];
    }
    return _toolView;
}

- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        //发射器在xy平面中心位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.width - 50, self.moviePlayer.view.height - 50);
        //发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        //渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        //开启三围效果
//        _emitterLayer.preservesDepth = YES;
        NSMutableArray *array = [NSMutableArray array];
        //创建粒子
        for (int i = 0; i < 10; i ++) {
            //发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            //粒子的创建速率  默认为1/s
            stepCell.birthRate = 1;
            //粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            //粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
            //粒子显示的内容
            stepCell.contents = (id)[image CGImage];
            //粒子运动速度
            stepCell.velocity = arc4random_uniform(100) + 100;
            //粒子速度的容差
            stepCell.velocityRange = 80;
            //粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI + M_PI_2;
            //粒子发射角度的容差
            stepCell.emissionRange = M_PI_2 / 6;
            //缩放比例
            stepCell.scale = 0.3;
            [array addObject:stepCell];
            
        }
        
        emitterLayer.emitterCells = array;
        [self.moviePlayer.view.layer insertSublayer:emitterLayer above:self.catEarView.layer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.toolView.hidden = NO;
        
        _renderer = [[BarrageRenderer alloc] init];
        _renderer.canvasMargin = UIEdgeInsetsMake(ScreenHeight * 0.3, 10, 10, 10);
        [self.contentView addSubview:_renderer.view];
        
        NSSafeObject *safeObj = [[NSSafeObject alloc] initWithObject:self withSelector:@selector(autoSendBarrage)];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:safeObj selector:@selector(exeute) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)setLive:(ZRSLiveItem *)live {
    _live = live;
    self.anchorView.live = live;
    [self playFLV:live.flv placeHolderUrl:live.bigpic];
}

- (void)setRelateLive:(ZRSLiveItem *)relateLive {
    _relateLive = relateLive;
    //设置相关主播
    if (relateLive) {
        self.catEarView.live = relateLive;
    } else {
        self.catEarView.hidden = YES;
    }
}

#pragma mark - private method 
- (void)playFLV:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl {
    if (_moviePlayer) {
        if (_moviePlayer) {
            [self.contentView insertSubview:self.placeHolderView aboveSubview:_moviePlayer.view];
        }
        if (_catEarView) {
            [_catEarView removeFromSuperview];
            _catEarView = nil;
        }
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    //如果切换主播， 取消之前的动画
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:placeHolderUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        [self.parentVc showGifLoading:nil inView:self.placeHolderView];
        self.placeHolderView.image = [UIImage blurImage:image blur:0.8];
    }];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    
    //帧速率（fps） (可以改，确认非标准帧会导致音画不同步， 所以只能设定为15或者29。97)
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    //-vol-设置音量大小， 256为标准音量。（要设置成两倍音量时则输入512）；
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
    moviePlayer.view.frame = self.contentView.bounds;
    //填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    //设置自动播放（必须设置为NO， 防止自动播放， 才能更好的控制直播的状态）
    moviePlayer.shouldAutoplay = NO;
    //默认不显示
    moviePlayer.shouldShowHudView = NO;
    [self.contentView insertSubview:moviePlayer.view atIndex:0];
    [moviePlayer prepareToPlay];
    self.moviePlayer = moviePlayer;
    //设置监听
    [self initObserver];
    //显示工会其他主播和类似主播
    [moviePlayer.view bringSubviewToFront:self.otherView];
    //开始来访动画
    [self.emitterLayer setHidden:NO];
    
}

@end
