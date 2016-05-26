//
//  ThirdViewController.h
//  AVPCamara
//
//  Created by 肖敏 on 16/3/1.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImagePickerController  *imagePicker;

@property (weak, nonatomic) IBOutlet UIImageView *photeImage;

@end
