//
//  EMABUserAccountTableViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABUserAccountTableViewController.h"
#import "EMABUser.h"
@interface EMABUserAccountTableViewController ()

@end

@implementation EMABUserAccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0)?4:1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [PFUser logOut];
        UIStoryboard *dispatchStoryboard = [UIStoryboard storyboardWithName:@"LoginSignup" bundle:nil];
        UINavigationController *navController = (UINavigationController *)[dispatchStoryboard instantiateInitialViewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
