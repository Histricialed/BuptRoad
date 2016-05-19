//
//  CustomImagePickerView.h
//  CustomImagePicker
//
//  Created by 李志强 on 16/4/27.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImagePickerController+Addition.h"

@interface CustomImagePickerView : UIView<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) ImagePickerViewType imagePickerViewType;
@property (nonatomic, weak) UIImagePickerController *imageViewController;
@property (nonatomic, copy) didFinishPickingImageWithInfoBlock finishBlock;

@end
