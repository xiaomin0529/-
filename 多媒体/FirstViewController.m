//
//  FirstViewController.m
//  AVPCamara
//
//  Created by 肖敏 on 16/3/1.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "FirstViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define xmSong @"哪里都是你.mp3"
#define xmSinger @"周杰伦"
#define xmSongTitle @"哪里都是你"

@interface FirstViewController ()<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;  //播放器对象
@property (weak, nonatomic) IBOutlet UIView *audioView;   //弹出的播放界面
@property (weak, nonatomic) IBOutlet UIProgressView *musicProgress;  //播放进度

@property (weak, nonatomic) IBOutlet UILabel *SongName;
@property (weak, nonatomic) IBOutlet UILabel *singer;

@property (weak,nonatomic) NSTimer *timer; //播放进度更新定时器

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.SongName.text = xmSongTitle;
    self.singer.text = xmSinger;
    self.audioView.hidden = YES;
    
    }
//播放音频
- (IBAction)playAudio:(id)sender {
    [self playSoundEffect:@"1.aiff"];
}
//播放音乐   .mp3
- (IBAction)playMusic:(id)sender {
    self.audioView.hidden = !self.audioView.hidden;
}

// C方法，音频完成的回调
void soundCompletedCallback(SystemSoundID soundId,void * cliendData) {
    NSLog(@"音频播放完成");
}

- (void)playSoundEffect:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:audioFile];
    //系统声音的指针，
    SystemSoundID soundId = 0;
    //获得系统声音指针
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &soundId);
    //添加监视
    AudioServicesAddSystemSoundCompletion(soundId, NULL, NULL,soundCompletedCallback, NULL);
    //播放系统声音
    AudioServicesPlaySystemSound(soundId);
//    AudioServicesPlayAlertSound(soundId); //声音带振动的
    
}


#pragma mark 下面播放音乐的方法

//创建播放器的get方法
-(AVAudioPlayer *) audioPlayer {
    if (!_audioPlayer) {
        NSString *urlStr = [[NSBundle mainBundle] pathForResource:xmSong ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        NSError *error = nil;
        _audioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        
        _audioPlayer.numberOfLoops = 0;
        _audioPlayer.delegate = self; //
        [_audioPlayer prepareToPlay]; //加载文件到缓存
        if (error) {
            NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

#pragma mark 定时器更新播放进度
- (NSTimer *) timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void) updateProgress {
    float progress = self.audioPlayer.currentTime / self.audioPlayer.duration;
    [self.musicProgress setProgress:progress animated:YES];
}


#pragma mark 三个控制播放的方法
- (IBAction)playAndPause:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"暂停"]) {
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [self.audioPlayer play];
        self.timer.fireDate = [NSDate distantPast]; //恢复定时器
    } else {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [self.audioPlayer pause];
        self.timer.fireDate = [NSDate distantFuture]; //暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
    }
    
}

#pragma mark 是否和其他app同时播放音乐
- (IBAction)setAudioSessionCategory:(UISegmentedControl *)sender {
    NSError *error;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //    audioSession.category = AVAudioSessionCategorySoloAmbient;
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    //声音独占
    if (sender.numberOfSegments==1) {
        [audioSession setCategory:AVAudioSessionCategorySoloAmbient error:&error];
    //声音混合
    } else if (sender.numberOfSegments == 2) {
        [audioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    }
    //必须要setActive才能生效
    [audioSession setActive:YES error:&error];
    if (error) {
        NSLog(@"audioSession 设置独占模式出错");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
