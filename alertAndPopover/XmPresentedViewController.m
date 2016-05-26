//
//  XmPresentedViewController.m
//  alertAndPopover
//
//  Created by 肖敏 on 16/3/7.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmPresentedViewController.h"
#import "XmPresentationController.h"

@implementation XmPresentedViewController

- (instancetype)init
{
    if ((self = [super init])) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}


-(void)viewDidLoad {
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:self.view.frame];
    effectView.effect = effect;
    [self.view addSubview:effectView];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(dismissVC:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.frame = CGRectMake(50, 100, 70, 40);
    [effectView.contentView addSubview:doneBtn];
}


- (void)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSLog(@"presentationControllerForPresentedViewController");
    if (presented == self) {
        NSLog(@"presented self");
        XmPresentationController *presen = [[XmPresentationController alloc ]initWithPresentedViewController:presented presentingViewController:presenting];
        
        return presen;
    }
    return nil;
}

@end
