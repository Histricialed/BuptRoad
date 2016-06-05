//
//  BRBuildingDetailViewController.m
//  BuptRoad
//
//  Created by 李志强 on 16/6/1.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRBuildingDetailViewController.h"
#import "BRBuildingModel.h"


@interface BRBuildingDetailViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UILabel *doorDirection;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *totalFloor;
@property (weak, nonatomic) IBOutlet UILabel *function;
@property (weak, nonatomic) IBOutlet UILabel *openTime;
@property (weak, nonatomic) IBOutlet UILabel *closeTime;
@property (weak, nonatomic) IBOutlet UITextView *remark;


@end

@implementation BRBuildingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.buildingModel.buildingName;
    [self initLabels];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initLabels {
    if ([self.buildingModel.detailImageName length]) {
        self.bigImage.image = [UIImage imageNamed:self.buildingModel.detailImageName];
    } else {
        self.bigImage.image = [UIImage imageNamed:@"noimagebig"];
    }
    self.doorDirection.text = self.buildingModel.doorDirection;
    self.position.text = self.buildingModel.position;
    self.totalFloor.text = self.buildingModel.totalFloor;
    self.function.text = self.buildingModel.function;
    self.openTime.text = self.buildingModel.openTime;
    self.closeTime.text = self.buildingModel.closeTime;
    self.remark.text = self.buildingModel.remark;
    self.remark.font = [UIFont systemFontOfSize:18.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
