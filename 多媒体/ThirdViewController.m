//
//  ThirdViewController.m
//  AVPCamara
//
//  Created by 肖敏 on 16/3/1.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "ThirdViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation ThirdViewController



- (IBAction)showImagePicker:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择以下方式更换头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *a){
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#pragma mark 这句好像没想到作用：NO动画仍然有动画，不加dismiss也可以二次presentVC.
        [self dismissViewControllerAnimated:NO completion:nil]; //
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *a){
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *a){
        [self dismissViewControllerAnimated:NO completion:nil];
    }];

    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)viewDidLoad {
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //imagePicker.mediaType数组中包含kUTTypeImage!
    //kUTTypeImage定义在MobileCoreServices.framework中,此默认。 摄像为kUTTypeVedio/Movie
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image;
        if (self.imagePicker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        _photeImage.image = image; //此时只是临时图片，并没有保存本地。 下次找开就没了。
        
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImagePickerController *) imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        //来源：相片库，已保存相册，摄像头。   相片库：包括相册、app保存的图片等，最全；已保存相册，即相册照出来的，和手动保存的；
        //微信等就使用相片库，也是默认
        //_imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera; //default photoLibrary
        
        //默认是英文界面， 选为中文： target-info- Localization native development region由en改为china
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self; //必须还要实现UINavigationControllerDelegate协议，否则有warn
        
    }
    return _imagePicker;
}
@end
