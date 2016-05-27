//
//  BRBuildingListTableViewController.m
//  BuptRoad
//
//  Created by 李志强 on 16/5/26.
//  Copyright © 2016年 LaFleur. All rights reserved.
//

#import "BRBuildingListTableViewController.h"
#import "BRBuildingCell.h"
#import "BRBuildingModelStore.h"
#import "BRBuildingModel.h"

@interface BRBuildingListTableViewController ()

@end

@implementation BRBuildingListTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"建筑列表";
        UIImage *tabIcon = [UIImage imageNamed:@"icon_tabbar_camera"];
        self.tabBarItem.image = tabIcon;
        for (int i = 0; i < 13; i++) {
            [[BRBuildingModelStore sharedStore] createItemByBuildingID:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"BRBuildingCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BRBuildingCell"];
    
    self.navigationItem.title = @"建筑列表";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:244/255.0 blue:180/255.0 alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:55/255.0 green:205/255.0 blue:151/255.0 alpha:1.0];
    [self.tableView reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BRBuildingModelStore sharedStore] allItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BRBuildingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BRBuildingCell" forIndexPath:indexPath];
    NSArray *buildings = [[BRBuildingModelStore sharedStore] allItems];
    BRBuildingModel *building = buildings[indexPath.row];
    cell.buildingName.text = building.buildingName;
    [cell.buildingImage setImage:[UIImage imageNamed:building.imageName]];
    cell.location.text = building.position;
    cell.function.text = building.function;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 101;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
