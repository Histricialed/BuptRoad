//
//  BRAreaModel.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/23.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRAreaModel.h"
#import <math.h>

// 识别范围角度
static const double Theta = 40;
static const double latitudeScale = 113.990; //1°纬度约为113.990KM
static const double longtitudeScale = 86.757; //1°经度约为86.757KM

@implementation BRAreaModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _radius = 0;
    }
    return self;
}

- (BOOL)isPoint:(double)latitude and:(double)longtitude InArea:(BRAreaModel *)area
{
    double cosTheta = cos(Theta / 2 / (180/3.1415926535));
    double headingVectorX = sin(area.currentHeading.trueHeading / (180/3.1415926535));
    double headingVectorY = cos(area.currentHeading.trueHeading / (180/3.1415926535));
    NSLog(@"headingVectorX  %lf ,headingVectorY  %lf",headingVectorX,headingVectorY);
    double squaredRadius = area.radius * area.radius * 100 * 100;
    NSLog(@"squaredRadius = %lf",squaredRadius);
    if (squaredRadius <= 0) {
        return NO;
    }
    
    double dX = (longtitude - area.currentLocation.coordinate.longitude) * longtitudeScale;
    double dY = (latitude - area.currentLocation.coordinate.latitude) * latitudeScale;
    NSLog(@"dX:%lf,dY:%lf",dX,dY);
    double squaredLength = dX * dX + dY * dY;
    NSLog(@"squaredLength = %lf",squaredLength);
    if (squaredLength > squaredRadius) {
        return NO;
    }
    
    // D点与朝向向量做点乘
    double DdotHeadingVector = dX * headingVectorX + dY * headingVectorY;
    NSLog(@"DdotHeadingVector = %lf ,cosTheta = %lf",DdotHeadingVector,cosTheta);
    if (DdotHeadingVector >= 0 && cosTheta >= 0) {
        return DdotHeadingVector * DdotHeadingVector > squaredLength * cosTheta * cosTheta;
    } else if (DdotHeadingVector < 0 && cosTheta < 0) {
        return DdotHeadingVector * DdotHeadingVector < squaredLength * cosTheta * cosTheta;
    } else {
        return DdotHeadingVector >= 0;
    }
}

@end
