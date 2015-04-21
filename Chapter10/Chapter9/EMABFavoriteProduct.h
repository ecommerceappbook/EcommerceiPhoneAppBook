//
//  EMABFavoriteProduct.h
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import <Parse/Parse.h>

@class EMABUser;
@class EMABProduct;
@interface EMABFavoriteProduct : PFObject<PFSubclassing>
@property (nonatomic, strong) EMABUser *customer;
@property (nonatomic, strong) EMABProduct *product;

+(PFQuery *)basicQuery;
+(PFQuery *)queryForCustomer:(EMABUser *)customer product:(EMABProduct *)product;
@end
