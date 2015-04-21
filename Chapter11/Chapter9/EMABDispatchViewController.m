//
//  EMABDispatchViewController.m
//  Chapter6
//
//  Created by Liangjun Jiang on 4/18/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABDispatchViewController.h"
#import "EMABConstants.h"
@interface EMABDispatchViewController ()

@end

@implementation EMABDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(IBAction)onFacebookLogin:(id)sender{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsLoggedInfKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)onCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
