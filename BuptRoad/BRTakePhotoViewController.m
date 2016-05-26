//
//  BRTakePhotoViewController.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/13.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRTakePhotoViewController.h"
#import "UIImagePickerController+Addition.h"

@interface BRTakePhotoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *takePhotoBtn;

@end

@implementation BRTakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"邮路";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:244/255.0 blue:180/255.0 alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:55/255.0 green:205/255.0 blue:151/255.0 alpha:1.0];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController imagePickerControllerWithType:ImagePickerViewTypeContract finishBlock:^(UIImage *imageInfo) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = imageInfo;
            if (!image || image.size.width == 0 || image.size.height == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"获取照片错误");
                });
            }
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = [UIImage imageWithData:imageData];
            });
        });
    }];
    [self presentViewController:picker animated:YES completion:^{}];//进入照相界面

}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"拍照";
        UIImage *tabIcon = [UIImage imageNamed:@"icon_tabbar_camera"];
        self.tabBarItem.image = tabIcon;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
