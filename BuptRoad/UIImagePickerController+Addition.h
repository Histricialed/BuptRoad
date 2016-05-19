//
//  UIImagePickerController+Addition.h
//  CustomImagePicker
//
//  Created by 李志强 on 16/5/9.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didFinishPickingImageWithInfoBlock)(UIImage *image);

typedef NS_ENUM(NSInteger, ImagePickerViewType) {
    ImagePickerViewTypeContract,
    ImagepickerviewTypePersonCard
};

@interface UIImagePickerController (Addition)

+ (UIImagePickerController *)imagePickerControllerWithType:(ImagePickerViewType)type finishBlock:(didFinishPickingImageWithInfoBlock)block;

@end
