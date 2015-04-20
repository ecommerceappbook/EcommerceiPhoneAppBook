//
//  EMABCategoryTableViewCell.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABCategoryTableViewCell.h"
#import <ParseUI/PFImageView.h>

@interface EMABCategoryTableViewCell()
@property (nonatomic, weak) IBOutlet PFImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@end;


@implementation EMABCategoryTableViewCell

-(void)configureItem:(EMABCategory *)item
{
    
    
}

@end
