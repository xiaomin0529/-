//
//  FirstViewController.h
//  alertAndPopover
//
//  Created by 肖敏 on 16/3/6.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (nonatomic,strong) UIAlertController *alertController;
@property (weak, nonatomic) IBOutlet UILabel *PressResult;

@end

