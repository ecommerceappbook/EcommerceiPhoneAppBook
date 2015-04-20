//
//  EMABProduct.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABProduct.h"
#import  <Parse/PFObject+Subclass.h>
#import "EMABConstants.h"
@implementation EMABProduct
@dynamic name, price, priceUnit, detail, thumbnail, fullsizeImage, brand;

+(NSString *)parseClassName
{
    return kProduct;
}

+(PFQuery *)basicQuery {
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query orderByAscending:@"name"];
    return query;
}


+(PFQuery *)queryForCategory:(EMABCategory *)brand{
    PFQuery  *query = [self basicQuery];
    [query whereKey:@"brand" equalTo:brand];
    return query;
}

-(NSString *)friendlyPrice{
    return [NSString localizedStringWithFormat:@"$ %.2f/%@", self.price, self.priceUnit];
}
@end
