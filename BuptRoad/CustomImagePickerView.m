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

#define SCREEN_WIDTH  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

@interface CustomImagePickerView ()

@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, weak) UIButton *takePhotoBtn;
@property (nonatomic, weak) UIButton *cancleBtn;
@property (nonatomic, weak) UIImageView *photoImageView;
@property (nonatomic, weak) UIButton *usePhotoBtn;
@property (nonatomic, strong) UIImage *imageInfo;
@property (nonatomic, weak) UIImageView *mask;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) BRAreaModel *area;

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
    self.area = [[BRAreaModel alloc] init];
//    self.area.radius = 0.011764;
    self.area.radius = 0.03;

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
    [super layoutSubviews];
    if (self.imagePickerViewType == ImagePickerViewTypeContract) {
        self.tipLabel.frame = CGRectMake(40, 20, SCREEN_WIDTH - 80, 30);
    } else if (self.imagePickerViewType == ImagepickerviewTypePersonCard){
        self.tipLabel.frame = CGRectMake(40, 140, SCREEN_WIDTH - 80, 30);
    }
    self.tipLabel.text = @"请将建筑物置于取景框中";
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor whiteColor];
    
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
    [self.usePhotoBtn setTitle:@"使用照片" forState:UIControlStateNormal];
}

- (void)shutterCamera {
    [self.imageViewController takePicture];
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];

//    double x = 39.9973712933;
//    double y = 116.3350445980;
    
//    NSLog(@"%@",[self.area isPoint:x and:y InArea:self.area]?@"YES":@"NO");
    //算法
//    [self.locationManager stopUpdatingHeading];
//    [self.locationManager stopUpdatingLocation];//或者写在上面的算法内
}


-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(nonnull CLHeading *)newHeading {
    self.area.currentHeading = newHeading;
    NSLog(@"heading---%f",newHeading.trueHeading);
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation=[locations lastObject];
    
//    location.strLatitude=[NSString stringWithFormat:@"%f",currLocation.coordinate.latitude];
//    location.strLongitude=[NSString stringWithFormat:@"%f",currLocation.coordinate.longitude];
    self.area.currentLocation = currLocation;
    NSLog(@"la---%f, lo---%f",currLocation.coordinate.latitude,currLocation.coordinate.longitude);
    double x = 39.9973712933;
    double y = 116.3350445980;
    NSLog(@"%@",[self.area isPoint:x and:y InArea:self.area]?@"YES":@"NO");
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
    self.mask.hidden = YES;
    self.tipLabel.hidden = YES;
    [self.cancleBtn setTitle:@"重拍" forState:UIControlStateNormal];
    self.takePhotoBtn.hidden = YES;

}

- (void)showControls {
    self.photoImageView.image = nil;
    self.photoImageView.hidden = YES;
    self.usePhotoBtn.hidden = YES;
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
