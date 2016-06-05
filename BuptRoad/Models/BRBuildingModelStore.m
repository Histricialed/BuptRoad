//
//  BRBuildingModelStore.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/27.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRBuildingModelStore.h"
#import "BRBuildingModel.h"

@interface BRBuildingModelStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BRBuildingModelStore

+ (instancetype)sharedStore {
    static BRBuildingModelStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (BRBuildingModel *)createItemByBuildingID:(NSString *)buildingID {
    BRBuildingModel *item = [BRBuildingModel buildingInfoByBuildingID:[NSString stringWithFormat:@"building - %@",buildingID]];
    [self.privateItems addObject:item];
    return item;
}

@end
