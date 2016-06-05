//
//  BRBuildingCell.h
//  BuptRoad
//
//  Created by 李志强 on 16/5/26.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRBuildingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UILabel *buildingName;
@property (weak, nonatomic) IBOutlet UILabel *function;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIView *view;

@end
