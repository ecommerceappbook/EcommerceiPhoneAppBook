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
@property (nonatomic, weak) IBOutlet UIButton *heartButton;
@end

@implementation EMABProductDetailViewController

-(void)setProduct:(EMABProduct *)product{
    if (_product !=product) {
        _product = product;
        
        [self updateUI];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

-(void)updateUI{
    if (self.product.fullsizeImage) {
       self.fullsizeImageView.file = self.product.fullsizeImage;
    }
    
    [self.fullsizeImageView loadInBackground];
    self.productNameLabel.text = self.product.name;
    self.productPriceLabel.text = [self.product friendlyPrice];
    self.detailTextView.text = [self.product detail];
}


-(IBAction)onBag:(id)sender
{
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self showWarning];
    } else {
        //todo:
    }
    
}


-(IBAction)onFavorite:(id)sender{
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self showWarning];
    } else {
        EMABFavoriteProduct *favoriteProduct = [EMABFavoriteProduct object];
        [favoriteProduct setCustomer:[PFUser currentUser]];
        [favoriteProduct setProduct:self.product];
        [favoriteProduct saveInBackgroundWithBlock:^(BOOL success, NSError *error){
            if (!error) {
                 [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", @"Success") message:NSLocalizedString(@"Successfully added", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil] show];
            }
        }];
    }
}


-(IBAction)onShare:(id)sender {
    
    
    
}

#pragma mark - helper
-(void)checkIfFavorited
{
    if (![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        PFQuery *fPQuery = [EMABFavoriteProduct queryForCustomer:[PFUser currentUser] product:self.product];
        [fPQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
            if (!error) {
                self.heartButton.enabled = false;
            }
        }];
    }
}


-(void)showWarning
{
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", @"Warning") message:NSLocalizedString(@"Please sign up or log in", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil] show];
}

//hear.png http://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Heart_coraz%C3%B3n.svg/2000px-Heart_coraz%C3%B3n.svg.png

@end
