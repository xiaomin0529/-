//
//  XmPresentationController.m
//  alertAndPopover
//
//  Created by 肖敏 on 16/3/7.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmPresentationController.h"

@implementation XmPresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    if ((self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController])) {
        _dimmingView = [[UIView alloc] init];
        _dimmingView.backgroundColor = [UIColor clearColor];
        _dimmingView.alpha = 0;
        
    }
    return self;
}



#pragma warn 父类重写的5个方法
/**
 * 容器里呈现VC时调用的 will & did
 */
-(void)presentationTransitionWillBegin {
    NSLog(@"presentationTransitionWillBegin");
    //官网例子
    [self.containerView addSubview:_dimmingView];
    [_dimmingView addSubview:self.presentedViewController.view];
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    //Fade in the dimming view during the transition.
    [_dimmingView setAlpha:0.0];
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [_dimmingView setAlpha:1.0];
    } completion:nil];
}

-(void)presentationTransitionDidEnd:(BOOL)completed {
    NSLog(@"presentationTransionDidEnd");
    //什么叫呈现结束但未完成transition？
    if (!completed) {
        [_dimmingView removeFromSuperview];
    }
}


#pragma mark 返回容器VC时调用, will & did
-(void)dismissalTransitionWillBegin {
    NSLog(@"dismissalTransitionWIllbegin");
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [_dimmingView setAlpha:0.0];
    } completion:nil];
}

-(void)dismissalTransitionDidEnd:(BOOL)completed {
    NSLog(@"dismissalTransitionDidEnd");
    if (completed) {
        [_dimmingView removeFromSuperview];
    }
}

#pragma mark - VC呈现在容器里的位置
-(CGRect)frameOfPresentedViewInContainerView {
    //调整presentedVC的大小位置
    CGRect frame = self.containerView.bounds;
    frame = CGRectInset(frame, 0, 50);
    return frame;
}

@end
