//
//  BRAreaModel.h
//  BuptRoad
//
//  Created by 李志强 on 16/5/23.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class BRBuildingModel;

@interface BRAreaModel : NSObject

@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLHeading *currentHeading;
@property (nonatomic, assign) double radius;

- (instancetype)init;
- (BOOL)isBuildingInArea:(BRBuildingModel *)building;

@end
