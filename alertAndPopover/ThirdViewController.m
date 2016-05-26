//
//  ThirdViewController.m
//  alertAndPopover
//
//  Created by 肖敏 on 16/3/7.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "ThirdViewController.h"
#import "XmPresentedViewController.h"

@implementation ThirdViewController


- (IBAction)presentVC:(id)sender {
    XmPresentedViewController *presentedVC = [[XmPresentedViewController alloc] init];
    [self presentViewController:presentedVC animated:YES completion:nil];
}

@end
