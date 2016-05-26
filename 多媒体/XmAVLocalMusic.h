//
//  XmAVLocalMusic.h
//  AVPCamara
//
//  Created by 肖敏 on 16/3/2.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface XmAVLocalMusic : UIViewController<MPMediaPickerControllerDelegate>

@property (nonatomic,strong) MPMediaPickerController *mediaPicker; //媒体选择
@property (nonatomic,strong) MPMusicPlayerController *musicPlayer; //音乐播放器

@property (weak, nonatomic) IBOutlet UILabel *song;
@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UIImageView *faceImage;
@property (weak, nonatomic) IBOutlet UIImageView *musicProcess;


@end
