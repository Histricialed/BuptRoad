//
//  BRBuildingModelStore.h
//  BuptRoad
//
//  Created by 李志强 on 16/5/27.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BRBuildingModel;

@interface BRBuildingModelStore : NSObject

+ (instancetype)sharedStore;
- (NSArray *)allItems;
- (BRBuildingModel *)createItemByBuildingID:(NSString *)buildingID;

@end
