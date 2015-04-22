//
//  EMABProductsFilterViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABProductsFilterViewController.h"

@interface EMABProductsFilterViewController (){
    float minPrice;
    float maxPrice;
}

@property (nonatomic, weak) IBOutlet UILabel *minLabel;
@property (nonatomic, weak) IBOutlet UILabel *maxLabel;

@end

@implementation EMABProductsFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    minPrice = 0.0;
    maxPrice = 0.0;
}


-(IBAction)onSlider:(id)sender{
    UISlider *slider = (UISlider *)sender;
    NSString *friendlySliderValue = [NSString stringWithFormat:@"%.0f",slider.value];;
    if (slider.tag == 99) {
        minPrice = slider.value;
        self.minLabel.text = friendlySliderValue;
    } else {
        maxPrice = slider.value;
        self.maxLabel.text = friendlySliderValue;
    }
    
}

-(IBAction)onCancel:(id)sender{
    self.cancelBlock(self);
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onDone:(id)sender{
    if (minPrice > 0 && minPrice < maxPrice) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"Please make sure your max price is greater than your min price.", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        self.finishBlock(self, minPrice, maxPrice);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
