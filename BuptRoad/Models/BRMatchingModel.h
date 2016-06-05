//
//  BRMatchingModel.h
//  BuptRoad
//
//  Created by 李志强 on 16/6/5.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BRBuildingModel;
@class BRAreaModel;


@interface BRMatchingModel : NSObject


- (BRBuildingModel*)matchingBuildingsInArea:(BRAreaModel*)area;
+ (instancetype)sharedInstance;
- (instancetype)initPrivate;

@end
