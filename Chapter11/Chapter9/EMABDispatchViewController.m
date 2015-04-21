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
    
}


-(IBAction)onFacebookLogin:(id)sender{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsLoggedInfKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)onCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
