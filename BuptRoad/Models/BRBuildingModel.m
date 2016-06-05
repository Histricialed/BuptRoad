//
//  BRBuildingModel.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/27.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRBuildingModel.h"

@interface BRBuildingModel()


@end

@implementation BRBuildingModel

- (id)initWithBuildingID:(NSNumber *)buildingID
                   imageName:(NSString *)imageName
             detailImageName:(NSString *)detailImageName
                buildingName:(NSString *)buildingName
                    latitude:(double)latitude
                  longtitude:(double)longtitude
                    openTime:(NSString *)openTime
                   closeTime:(NSString *)closeTime
                  totalFloor:(NSString *)totalFloor
               doorDirection:(NSString *)doorDirection
                    position:(NSString *)position
                    function:(NSString *)function
                      remark:(NSString *)remark
{
    self = [super init];
    if (self) {
        self.buildingID = buildingID;
        self.imageName = imageName;
        self.detailImageName = detailImageName;
        self.buildingName = buildingName;
        self.latitude = latitude;
        self.longtitude = longtitude;
        self.openTime = openTime;
        self.closeTime = closeTime;
        self.totalFloor = totalFloor;
        self.doorDirection = doorDirection;
        self.position = position;
        self.function = function;
        self.remark = remark;
    }
    return self;
}


+ (NSDictionary *)sharedDictionary {
    static NSDictionary *sharedDictionary = nil;
    
    if (!sharedDictionary) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"buildinginfo" ofType:@"plist"];
        sharedDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    
    return sharedDictionary;
}

+ (id)buildingInfoByBuildingID:(NSString *)buildingID {
    NSDictionary *dict = [self sharedDictionary];
    NSDictionary *tempDict = [NSDictionary dictionaryWithDictionary:[dict objectForKey:buildingID]];
    BRBuildingModel *building = [[self alloc] initWithBuildingID:[NSNumber numberWithInt:0]
                                                       imageName:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"imageName"]]
                                                 detailImageName:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"detailImageName"]]
                                                    buildingName:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"buildingName"]]
                                                        latitude:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"latitude"]].doubleValue
                                                      longtitude:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"longtitude"]].doubleValue
                                                        openTime:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"openTime"]]
                                                       closeTime:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"closeTime"]]
                                                      totalFloor:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"totalFloor"]]
                                                   doorDirection:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"doorDirection"]]
                                                        position:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"position"]]
                                                        function:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"function"]]
                                                          remark:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"remark"]]];
    
                                 
    return building;
}

@end