//
//  BRBuildingModel.h
//  BuptRoad
//
//  Created by 李志强 on 16/5/27.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BRBuildingModel : NSObject

@property (nonatomic, assign) NSNumber *buildingID;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *detailImageName;
@property (nonatomic, copy) NSString *buildingName;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longtitude;
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *closeTime;
@property (nonatomic, copy) NSString *totalFloor;
@property (nonatomic, copy) NSString *doorDirection;
@property (nonatomic, copy) NSString *doorDescription;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *function;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) double distance;
@property (nonatomic, assign) double angle;

- (id)initWithBuildingID:(NSNumber *)buildingID
               imageName:(NSString *)imageName
         detailImageName:(NSString *)detailImageName
                buildingName:(NSString *)buildingName
                    latitude:(double)latitude
                  longtitude:(double)loångtitude
                    openTime:(NSString *)openTime
                   closeTime:(NSString *)closeTime
                  totalFloor:(NSString *)totalFloor
               doorDirection:(NSString *)doorDirection
                    position:(NSString *)position
                    function:(NSString *)function
                      remark:(NSString *)remark;

+ (id)buildingInfoByBuildingID:(NSString *)buildingID;

@end