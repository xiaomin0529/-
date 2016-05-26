//
//  AppDelegate.m
//  本地推送
//
//  Created by 肖敏 on 16/1/19.
//  Copyright © 2016年 steven. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
    int _count;
}

@end

@implementation AppDelegate


#pragma mark 在app进入时判断是否被允许了本地通知。 有则设置本地通知， 无则注册一次，注册会弹出prompt让用户选择。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _count = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(abc:) userInfo:nil repeats:YES];
    
//    //1.如有，则添加本地通知
//    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types
//        != UIUserNotificationTypeNone) {
//        [self addLocalNotification];
//    //2.1 若无,则注册申请本地通知。 注册成功再添加（即调用didRegisterUserNotification方法，并在方法中添加本地通知）
//    } else {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
    return YES;
}

-(void)abc:(NSTimer *)sender {
    _count++;
    [UIApplication sharedApplication].applicationIconBadgeNumber=_count;
    NSLog(@"count:%d",_count);
    if (_count>=5) {
        [sender invalidate];
    }
}


#pragma mark 2.2 注册成功后会调用did方法。 此时要添加本地通知
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //NSLog(@"number:%ldl",notification.applicationIconBadgeNumber);
    //NSLog(@"log:%@",notification.userInfo);
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    [UIApplication sharedApplication].applicationIconBadgeNumber--;
    
}

#pragma mark 添加本地通知
-(void) addLocalNotification {
    UILocalNotification *notifi = [[UILocalNotification alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *notifiDate = [formatter dateFromString:@"2016-01-19 21:26:00"];
    notifi.fireDate = notifiDate;
    
//    notifi.applicationIconBadgeNumber++; 这个怎么加num都是显示1个
    [UIApplication sharedApplication].applicationIconBadgeNumber++; //只有application++才会显示多个
        //???? 但是现在不是fireDate时候图标增加， 而是每次后台就会++；
    notifi.alertBody = @"恭喜您！你购买的彩票中了一等奖！";
    notifi.alertAction = @"查看中奖信息";
    notifi.soundName = @"msg.caf";
    
    notifi.userInfo = @{@"username":@"xiaomin"};
    [[UIApplication sharedApplication] scheduleLocalNotification:notifi];
}

#pragma mark 通知呢，好像在app退出后只能接收，而不收后台运行后再本地通知。如后台运行，且到22点检查webJson，则尝试定时器。
#pragma mark 实验证明， 定时器只在active时才运转。 一到back就不动了更别说退出后了。 所以需要后台执行方法。

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //[self addLocalNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
