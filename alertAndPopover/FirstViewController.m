//
//  FirstViewController.m
//  alertAndPopover
//
//  Created by 肖敏 on 16/3/6.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "FirstViewController.h"
#define DISMISS_CONTROLLER [self dismissViewControllerAnimated:YES completion:nil]
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)alertEffects:(UIButton *)sender {
    _alertController = [UIAlertController alertControllerWithTitle:@"我是标题" message:@"我是信息内容" preferredStyle:UIAlertControllerStyleAlert];
    if (sender.tag==10) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            self.PressResult.text = @"确定";
            DISMISS_CONTROLLER;
        }];
        [self.alertController addAction:action];
        [self presentViewController:self.alertController animated:YES completion:nil];
    } else if (sender.tag == 11) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            self.PressResult.text = @"删除";
            DISMISS_CONTROLLER;
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            self.PressResult.text = @"Cancel";
            DISMISS_CONTROLLER;
        }];
        [self.alertController addAction:action1];
        [self.alertController addAction:action2];
        [self presentViewController:self.alertController animated:YES completion:nil];
    } else if (sender.tag == 13) {
#pragma warn ActionSheet会从底部弹出。在ipad中则是带箭头的popover(还要加些代码不然出错)且cancel按钮不显示
        _alertController = [UIAlertController alertControllerWithTitle:@"请用以下方式来设置头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            self.PressResult.text = @"打开相册imagePicker";
            DISMISS_CONTROLLER;
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            self.PressResult.text = @"摄像头imagePicker Camara";
            DISMISS_CONTROLLER;
        }];
#pragma warn 使用styleSheet时,StyleCancel会跑最下边，并与上面兄弟有间隔！ 而非sheet时，styleCancel会跑到左边，蓝色粗体
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            self.PressResult.text = @"Cancel";
            DISMISS_CONTROLLER;
        }];
        [self.alertController addAction:action1];
        [self.alertController addAction:action2];
        [self.alertController addAction:action3];
        [self presentViewController:self.alertController animated:YES completion:nil];
    } else if (sender.tag == 12) {
        self.alertController.title = @"请输入用户名，密码！";
        self.alertController.message = nil;
        [self.alertController addTextFieldWithConfigurationHandler:^(UITextField *t) {
            t.tintColor = [UIColor redColor];
            t.backgroundColor = [UIColor yellowColor];
            t.textColor = [UIColor greenColor];
#pragma warn 字体的粗斜怎么设置？ bold,italic...
        }];
        [self.alertController addTextFieldWithConfigurationHandler:^(UITextField *t) {
            t.tintColor = [UIColor blueColor];
            t.backgroundColor = [UIColor cyanColor];
            t.textColor = [UIColor redColor];
#pragma warn 输入密码时，显示为圆点
            t.secureTextEntry = YES;
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            UITextField *username = _alertController.textFields[0];
            UITextField *password = _alertController.textFields[1];
            self.PressResult.text = [NSString stringWithFormat:@"用户名：%@,密码：%@",username.text,password.text];
            NSLog(@"%@,%@",username.text,password.text);
#pragma warn 不能在dismiss的completion里加上此controller的present，而且多个app的alert有阻塞队列
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            self.PressResult.text = @"Cancel";
            DISMISS_CONTROLLER;
        }];
        [self.alertController addAction:action1];
        [self.alertController addAction:action2];
        [self presentViewController:self.alertController animated:YES completion:nil];
    }

}


//只能alertController调用
- (void) dismissAlertController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
