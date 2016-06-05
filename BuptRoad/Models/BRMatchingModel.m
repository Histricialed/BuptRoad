//
//  BRMatchingModel.m
//  BuptRoad
//
//  Created by 李志强 on 16/6/5.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRMatchingModel.h"
#import "BRBuildingModel.h"
#import "BRAreaModel.h"
#import "BRBuildingModelStore.h"

@interface BRMatchingModel()

@property (nonatomic) NSArray *privateItems;

@end


@implementation BRMatchingModel

+ (instancetype)sharedInstance {
    static BRMatchingModel *sharedInstance = nil;
    
    if (!sharedInstance) {
        sharedInstance = [[self alloc] initPrivate];
    }
    
    return sharedInstance;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSArray alloc] init];
        if (![[[BRBuildingModelStore sharedStore] allItems] count]) {
            for (int i = 0; i < 23; i++) {
                [[BRBuildingModelStore sharedStore] createItemByBuildingID:[NSString stringWithFormat:@"%d",i]];
            }
        }
        _privateItems = [[BRBuildingModelStore sharedStore] allItems];
    }
    return self;
}

- (BRBuildingModel*)matchingBuildingsInArea:(BRAreaModel*)area {

    NSMutableArray *matchedBuildings = [[NSMutableArray alloc] init];
    for (BRBuildingModel *model in self.privateItems) {
        if ([area isBuildingInArea:model]) {
            [matchedBuildings addObject:model];
        }
    }
    NSArray *sortBuildingAngle = [matchedBuildings copy];
    sortBuildingAngle = [sortBuildingAngle sortedArrayUsingComparator:^NSComparisonResult(BRBuildingModel *b1, BRBuildingModel *b2) {
        return b1.angle < b2.angle;
    }];
    
    NSArray *sortedBuildingDistance = [[NSArray alloc] init];
    if ([sortBuildingAngle count]) {
        if ([sortBuildingAngle count] == 1) {
            sortedBuildingDistance = [sortBuildingAngle objectAtIndex:0];
        } else {
            sortedBuildingDistance = [sortBuildingAngle subarrayWithRange:NSMakeRange(0, [sortBuildingAngle count]>2?3:[sortBuildingAngle count])];
        }

    } else {
        return nil;
    }
    if (![sortedBuildingDistance isKindOfClass:[BRBuildingModel class]]) {
        sortedBuildingDistance = [sortedBuildingDistance sortedArrayUsingComparator:^NSComparisonResult(BRBuildingModel *b1, BRBuildingModel *b2) {
            return b1.distance > b2.distance;
        }];
        return [sortedBuildingDistance objectAtIndex:0];
    }

    return sortedBuildingDistance;
}

@end
