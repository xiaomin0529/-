//
//  XmAVLocalMusic.m
//  AVPCamara
//
//  Created by 肖敏 on 16/3/2.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmAVLocalMusic.h"

@implementation XmAVLocalMusic



-(void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 是否后台插入提醒存在， 都要调用的 xm
-(void)dealloc {
    [self.musicPlayer endGeneratingPlaybackNotifications];
}
- (IBAction)showMediaPicker:(id)sender {
    [self presentViewController:self.mediaPicker animated:YES completion:nil];
}

#pragma mark 创建选择器
- (MPMediaPickerController *)mediaPicker {
    if (!_mediaPicker) {
        _mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic]; //音乐，广播，视频，any等
        _mediaPicker.allowsPickingMultipleItems = YES; //允许多选
        _mediaPicker.prompt = @"选择要播放的音乐";
        _mediaPicker.delegate = self;
    }
    return _mediaPicker;
}
#pragma mark 本地媒体队列
- (MPMediaQuery *) getLocalMediaQuery {
    MPMediaQuery *mediaQuery = [MPMediaQuery songsQuery];
    for (MPMediaItem *item in mediaQuery.items) {
        NSLog(@"标题：%@,%@",item.title,item.albumTitle);
    }
    return mediaQuery;
}


- (MPMediaItemCollection *) getLocalMediaItemCollection {
    MPMediaQuery *mediaQuery = [MPMediaQuery songsQuery];
    NSMutableArray *array = [NSMutableArray array];
    for (MPMediaItem *item in mediaQuery.items) {
        [array addObject:item];
    }
    MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:[array copy]]; //TODO
    return collection;
}

#pragma mark 选择器代理方法: 当选择了某一条后
-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    MPMediaItem *item  = [mediaItemCollection.items firstObject];
    NSString *title = item.title;
    NSString *artist = item.artist;
    UIImage *image = [item.artwork imageWithSize:CGSizeMake(100, 100)];
    NSLog(@"歌曲标题：%@,艺术家：%@",title,artist);
    
    _song.text = title;
    _artist.text = artist;
    _faceImage.image = image;
    
    [_musicPlayer setQueueWithItemCollection:mediaItemCollection];
    NSLog(@"音乐数量：%lu",mediaItemCollection.items.count);
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 创建播放器
- (MPMusicPlayerController *)musicPlayer {
    if (!_musicPlayer) {
        _musicPlayer  = [MPMusicPlayerController systemMusicPlayer]; //分为系统播放器和程序播放器appli..player, 决定退出是否停止播放。
        [_musicPlayer beginGeneratingPlaybackNotifications]; //开启通知， 否则监测不到MPMusicPlayerController的通知。
        [self addNotification];
    }
    return _musicPlayer;
}

- (void) addNotification {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(playbackStateChange:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
}
- (void) playbackStateChange:(NSNotification *)notification{
    switch (self.musicPlayer.playbackState) {
        case MPMusicPlaybackStatePlaying:
            NSLog(@"开始播放");
            break;
        case MPMusicPlaybackStatePaused:
            NSLog(@"播放暂停");
            break;
        case MPMusicPlaybackStateStopped:
            NSLog(@"播放停止");
            break;
        case MPMusicPlaybackStateSeekingForward:
            NSLog(@"向前");
            break;
        case MPMusicPlaybackStateSeekingBackward:
            NSLog(@"向后");
            break;
        default:
            break;
    }
}
- (IBAction)playOrPause:(UIButton *)sender {
    [self.musicPlayer play];//state
}
- (IBAction)stopMusic:(id)sender {
    [self.musicPlayer stop];
}
- (IBAction)previousMusic:(id)sender {
    NSLog(@"..%@",self.musicPlayer.nowPlayingItem.title);
    [self.musicPlayer skipToPreviousItem];
    NSLog(@"..%@",self.musicPlayer.nowPlayingItem.title);
}
- (IBAction)nextMusic:(id)sender {
    NSLog(@"..%@",self.musicPlayer.nowPlayingItem.title);
    [self.musicPlayer skipToNextItem];
    NSLog(@"..%@",self.musicPlayer.nowPlayingItem.title);
}





@end
