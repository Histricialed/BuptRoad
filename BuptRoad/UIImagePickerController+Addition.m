//
//  UIImagePickerController+Addition.m
//  CustomImagePicker
//
//  Created by 李志强 on 16/5/9.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "UIImagePickerController+Addition.h"
#import "CustomImagePickerView.h"



@implementation UIImagePickerController (Addition)

+ (UIImagePickerController *)imagePickerControllerWithType:(ImagePickerViewType)type finishBlock:(didFinishPickingImageWithInfoBlock)block {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    CustomImagePickerView *overlayView = [[CustomImagePickerView alloc] initWithFrame:CGRectMake(0, 0, picker.cameraOverlayView.bounds.size.width, picker.cameraOverlayView.bounds.size.height)];
    overlayView.backgroundColor = [UIColor clearColor];
    overlayView.imagePickerViewType = type;
    overlayView.imageViewController = picker;
    overlayView.finishBlock = block;
    picker.cameraOverlayView = overlayView;
    picker.showsCameraControls = NO;
    picker.delegate = overlayView;
    return picker;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
