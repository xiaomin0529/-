//
//  XmPresentationController.h
//  alertAndPopover
//
//  Created by 肖敏 on 16/3/7.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XmPresentationController : UIPresentationController
@property (nonatomic,strong) UIView *dimmingView;
//这,block..
@property (nonatomic,strong) void(^hidssView)();

@end
