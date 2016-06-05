//
//  CustomImagePickerView.m
//  CustomImagePicker
//
//  Created by 李志强 on 16/4/27.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "CustomImagePickerView.h"
#import <CoreLocation/CoreLocation.h>
#import "BRAreaModel.h"
#import "BRMatchingModel.h"
#import "BRBuildingModel.h"
#import "BRBuildingDetailViewController.h"
#import "Masonry.h"
#import "CONST.h"


#define SCREEN_WIDTH  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

@interface CustomImagePickerView ()

@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, weak) UIButton *resultLabel;
@property (nonatomic, weak) UIButton *takePhotoBtn;
@property (nonatomic, weak) UIButton *cancleBtn;
@property (nonatomic, weak) UIImageView *photoImageView;
@property (nonatomic, weak) UIButton *usePhotoBtn;
@property (nonatomic, strong) UIImage *imageInfo;
@property (nonatomic, weak) UIImageView *mask;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) BRAreaModel *area;
@property (nonatomic, strong) BRBuildingModel *matchedBuilding;
@property (nonatomic, assign) BOOL isDisplay;

@end

@implementation CustomImagePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.f;
    self.locationManager.headingFilter = 5.0f;
    [self.locationManager requestWhenInUseAuthorization];

    return self;
}

- (void)setupUI {
    UIButton *takePhotoBtn = [[UIButton alloc] init];
    self.takePhotoBtn = takePhotoBtn;
    [self.takePhotoBtn addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.takePhotoBtn];
    UIButton *cancelBtn = [[UIButton alloc] init];
    self.cancleBtn = cancelBtn;
    [self.cancleBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancleBtn];
    UIImageView *photoImageView = [[UIImageView alloc] init];
    self.photoImageView = photoImageView;
    [self addSubview:self.photoImageView];
    self.photoImageView.hidden = YES;
    UIButton *usePhotoBtn = [[UIButton alloc] init];
    self.usePhotoBtn = usePhotoBtn;
    [self addSubview:self.usePhotoBtn];
    [self.usePhotoBtn addTarget:self action:@selector(usePhoto) forControlEvents:UIControlEventTouchUpInside];
    self.usePhotoBtn.hidden = YES;
    UIImage *maskImage = [UIImage imageNamed:@"mask1"];
    UIImageView *mask = [[UIImageView alloc] initWithImage:maskImage];
    self.mask = mask;
    [self addSubview:self.mask];
    UILabel *tipLabel = [[UILabel alloc] init];
    self.tipLabel = tipLabel;
    [self addSubview:self.tipLabel];
    UIButton *resultLabel = [[UIButton alloc] init];
    self.resultLabel = resultLabel;
    [self.resultLabel addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.resultLabel];
    self.area = [[BRAreaModel alloc] init];
    self.area.radius = 0.02;
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];

}

-(void)clickButton:(id)sender{
    BRBuildingDetailViewController *vc = [[BRBuildingDetailViewController alloc]init];
    vc.buildingModel = self.matchedBuilding;
    [self.imageViewController pushViewController:vc animated:YES];
    }
    


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.imagePickerViewType == ImagePickerViewTypeContract) {
        CGFloat width = SCREEN_WIDTH - 120;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(60, 60, width, width*1.622)];
        CGContextAddPath(context, path.CGPath);
    } else if (self.imagePickerViewType == ImagepickerviewTypePersonCard){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat width = SCREEN_WIDTH - 30;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(15, 180, width, width/1.58)];
        CGContextAddPath(context, path.CGPath);
    }
    CGContextSetLineWidth(context, 2);
    [[UIColor whiteColor] set];
    CGContextStrokePath(context);
}

- (void)layoutSubviews {
    WEAKSELF();
    [super layoutSubviews];
    if (self.imagePickerViewType == ImagePickerViewTypeContract) {
        self.tipLabel.frame = CGRectMake(40, 20, SCREEN_WIDTH - 80, 30);
    } else if (self.imagePickerViewType == ImagepickerviewTypePersonCard){
        self.tipLabel.frame = CGRectMake(40, 140, SCREEN_WIDTH - 80, 30);
    }
    self.tipLabel.text = @"请将建筑物置于取景框中";
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor whiteColor];
    
    self.resultLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.titleLabel.textColor = [UIColor whiteColor];
    self.resultLabel.backgroundColor = [UIColor grayColor];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(80);
    }];
    self.resultLabel.hidden = YES;
    
    self.isDisplay = NO;
    
    self.takePhotoBtn.frame = CGRectMake((SCREEN_WIDTH - 80)/2, SCREEN_HEIGHT - 100, 80, 80);
    self.takePhotoBtn.backgroundColor = [UIColor lightGrayColor];
    self.takePhotoBtn.layer.masksToBounds = YES;
    self.takePhotoBtn.layer.cornerRadius = 40.0f;
    [self.takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    
    self.cancleBtn.frame = CGRectMake(30, SCREEN_HEIGHT - 85, 50, 50);
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.photoImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100);
    self.photoImageView.backgroundColor = [UIColor blackColor];
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.usePhotoBtn.frame = CGRectMake(SCREEN_WIDTH - 110, SCREEN_HEIGHT - 85, 80, 50);
    [self.usePhotoBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
}

- (void)shutterCamera {
    [self.imageViewController takePicture];
    [self.resultLabel setTitle:@"没有匹配到建筑物" forState:UIControlStateNormal];
    self.matchedBuilding = [[BRMatchingModel sharedInstance] matchingBuildingsInArea:self.area];
    if (self.matchedBuilding) {
        [self.resultLabel setTitle:self.matchedBuilding.buildingName forState:UIControlStateNormal];
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(nonnull CLHeading *)newHeading {
    if (!self.area.currentHeading) {
        self.area.currentHeading = [[CLHeading alloc] init];
    }
    self.area.currentHeading = newHeading;
    NSLog(@"heading:%@",newHeading);
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation=[locations lastObject];
    if (!self.area.currentLocation) {
        self.area.currentLocation = [[CLLocation alloc] init];
    }
    self.area.currentLocation = currLocation;
    NSLog(@"currLocation:%@",currLocation);
}

- (void)cancle:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"取消"]) {
        [self.imageViewController dismissViewControllerAnimated:YES completion:^{
        }];
    } else if ([sender.titleLabel.text isEqualToString:@"重拍"]) {
        [self showControls];
    }
   
}

- (void)usePhoto {
    __weak __typeof(&*self)weakSelf = self;
    if (self.finishBlock != nil) {
        self.finishBlock(weakSelf.imageInfo);
    }
    [self.imageViewController dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    if (!image || image.size.width == 0 || image.size.height == 0) {
        NSLog(@"获取照片错误");
        [picker dismissViewControllerAnimated:YES completion:^{

        }];
    } else {
        [self hideControls];
        self.photoImageView.image = image;
        self.imageInfo = image;
    }
}

- (void)hideControls {
    self.photoImageView.hidden = NO;
    self.usePhotoBtn.hidden = NO;
    self.resultLabel.hidden = NO;
    self.mask.hidden = YES;
    self.tipLabel.hidden = YES;
    [self.cancleBtn setTitle:@"重拍" forState:UIControlStateNormal];
    self.takePhotoBtn.hidden = YES;

}

- (void)showControls {
    self.photoImageView.image = nil;
    self.photoImageView.hidden = YES;
    self.usePhotoBtn.hidden = YES;
    self.resultLabel.hidden = YES;
    self.mask.hidden = NO;
    self.tipLabel.hidden = NO;
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.takePhotoBtn.hidden = NO;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
