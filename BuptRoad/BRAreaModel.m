//
//  BRAreaModel.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/23.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRAreaModel.h"
#import <math.h>

// 可视角度的余弦值
static const double cosTheta = 0.5;

@implementation BRAreaModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _radius = 0;
    }
    return self;
}

- (BOOL)isPoint:(double)x and:(double)y InArea:(BRAreaModel *)area
{
    double headingVectorX = sin(area.currentHeading.trueHeading);
    double headingVectorY = cos(area.currentHeading.trueHeading);
    double squaredRadius = area.radius * area.radius;
    
    if (squaredRadius <= 0) {
        return NO;
    }
    
    double dX = x - area.currentLocation.coordinate.latitude;
    double dY = y - area.currentLocation.coordinate.longitude;
    
    double squaredLength = dX * dX + dY * dY;
    
    if (squaredLength > squaredRadius) {
        return NO;
    }
    
    // D点与朝向向量做点乘
    double DdotHeadingVector = dX * headingVectorX + dY * headingVectorY;
    
    if (DdotHeadingVector >= 0 && cosTheta >= 0) {
        return DdotHeadingVector * DdotHeadingVector > squaredLength * cosTheta * cosTheta;
    } else if (DdotHeadingVector < 0 && cosTheta < 0) {
        return DdotHeadingVector * DdotHeadingVector < squaredLength * cosTheta * cosTheta;
    } else {
        return DdotHeadingVector >= 0;
    }
}

@end
