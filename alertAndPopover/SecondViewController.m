//
//  SecondViewController.m
//  alertAndPopover
//
//  Created by 肖敏 on 16/3/6.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "SecondViewController.h"
#import "XmPopoverViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma warn 在iphone上是没有系统popover类的，在ipad上有。QQ微信的都是自己写的。
}

 /*
  *新VC属性中：Size to-->Freedom; Status bar->none;
  *新VC大小：设想要大小，如200,100
  *在旧VC中button上右击拉segue至新VC，选popover;设置segueID
  *旧VC实现UIPopoverPresentationControllerDelegate协议，
  *
  */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
#pragma warn 然后设置如下：
    //1.判断是这个segue进来的
    if ([segue.identifier isEqualToString:@"popoverSegue"]) {
        //2.取出对应VC
        XmPopoverViewController *popVC = (XmPopoverViewController *)segue.destinationViewController;
        
        //3 modal呈现模式是popover
        popVC.modalPresentationStyle = UIModalPresentationPopover;
        //4. 关键一点： 新VC的popoverController，属性的属性delegate是self
        popVC.popoverPresentationController.delegate = self;
        //5. 实现协议的方法， 返回modal none;
    }
}

//实现协议方法
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (IBAction)addSomething:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
