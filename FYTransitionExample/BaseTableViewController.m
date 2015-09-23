//
//  BaseTableViewController.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ModalCollectionViewController.h"
#import "PushCollectionViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        ModalCollectionViewController *bcVC = [[ModalCollectionViewController alloc] initWithNibName:@"BaseCollectionViewController" bundle:nil];
        bcVC.title = @"Modal";
        [self.navigationController pushViewController:bcVC animated:YES];
    } else if(indexPath.row == 1 && indexPath.section == 0){
        PushCollectionViewController *bcVC = [[PushCollectionViewController alloc] initWithNibName:@"BaseCollectionViewController" bundle:nil];
        bcVC.title = @"Push";
        [self.navigationController pushViewController:bcVC animated:YES];
    } else if (indexPath.row == 0 && indexPath.section == 1){
        ModalCollectionViewController *bcVC = [[ModalCollectionViewController alloc] initWithNibName:@"BaseCollectionViewController" bundle:nil];
        bcVC.isCustom = YES;
        bcVC.title = @"CustomModal";
        [self.navigationController pushViewController:bcVC animated:YES];
    } else if (indexPath.row == 1 && indexPath.section == 1){
        PushCollectionViewController *bcVC = [[PushCollectionViewController alloc] initWithNibName:@"BaseCollectionViewController" bundle:nil];
        bcVC.title = @"Custom_Push";
        bcVC.isCustom = YES;
        [self.navigationController pushViewController:bcVC animated:YES];
    }
    
}


@end
