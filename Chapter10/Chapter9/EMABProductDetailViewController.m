//
//  EMABProductDetailViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABProductDetailViewController.h"
#import "EMABProduct.h"
#import <ParseUI/PFImageView.h>
#import "EMABOrder.h"
#import "EMABFavoriteProduct.h"
@interface EMABProductDetailViewController ()
@property (nonatomic, weak) IBOutlet PFImageView *fullsizeImageView;
@property (nonatomic, weak) IBOutlet UILabel *productNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *productPriceLabel;
@property (nonatomic, weak) IBOutlet UITextView *detailTextView;

@end

@implementation EMABProductDetailViewController

-(void)setProduct:(EMABProduct *)product{
    if (_product !=product) {
        _product = product;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(IBAction)onBag:(id)sender
{
   
    
}


-(IBAction)onFavorite:(id)sender{
    
    
    
}


@end
