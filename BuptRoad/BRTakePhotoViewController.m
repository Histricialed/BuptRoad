//
//  BRTakePhotoViewController.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/13.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRTakePhotoViewController.h"

@interface BRTakePhotoViewController ()

@end

@implementation BRTakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
