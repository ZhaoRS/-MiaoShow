//
//  ZRSCatEarView.m
//  MiaoShow
//
//  Created by 赵瑞生 on 2017/5/17.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ZRSCatEarView.h"
#import "ZRSLiveItem.h"

@interface ZRSCatEarView ()

@property (weak, nonatomic) IBOutlet UIView *playView;
/** 直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;

@end

@implementation ZRSCatEarView

+ (instancetype)catEarView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.playView.layer.cornerRadius = self.playView.height * 0.5;
    self.playView.layer.masksToBounds = YES;
}

- (void)setLive:(ZRSLiveItem *)live {
    _live = live;
    //设置只播放视频，不播放声音
    // github详解: https://github.com/Bilibili/ijkplayer/issues/1491#issuecomment-226714613
    IJKFFOptions *option = [IJKFFOptions optionsByDefault];
    [option setPlayerOptionValue:@"1" forKey:@"an"];
    //开启硬解码
    [option setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    IJKFFMoviePlayerController *moviewPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:live.flv withOptions:option];
    moviewPlayer.view.frame = self.playView.bounds;
    //填充fill
    moviewPlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    //设置自动播放
    moviewPlayer.shouldAutoplay = YES;
    [self.playView addSubview:moviewPlayer.view];
    
    [moviewPlayer prepareToPlay];
    self.moviePlayer = moviewPlayer;
}

- (void)removeFromSuperview {
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
    }
    [super removeFromSuperview];
}

/*
 //改进
 //[options setPlayerOptionIntValue:0 forKey:@"no-time-adjust"];
 //[options setPlayerOptionIntValue:1 forKey:@"audio_disable"];
 //[options setPlayerOptionIntValue:1 forKey:@"infbuf"];
 //[options setPlayerOptionIntValue:0 forKey:@"framedrop"];
 
 //videotoolbox 配置（硬件解码）
 [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
 
 
 [options setPlayerOptionIntValue:30     forKey:@"max-fps"];
 [options setPlayerOptionIntValue:0      forKey:@"framedrop"];
 [options setPlayerOptionIntValue:3      forKey:@"video-pictq-size"];
 [options setPlayerOptionIntValue:0      forKey:@"videotoolbox"];
 [options setPlayerOptionIntValue:960    forKey:@"videotoolbox-max-frame-width"];
 
 [options setFormatOptionIntValue:0                  forKey:@"auto_convert"];
 [options setFormatOptionIntValue:1                  forKey:@"reconnect"];
 [options setFormatOptionIntValue:30 * 1000 * 1000   forKey:@"timeout"];
 [options setFormatOptionValue:@"ijkplayer"          forKey:@"user-agent"];
 
*/


@end
