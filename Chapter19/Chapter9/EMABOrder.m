//
//  EMABOrder.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABOrder.h"
#import  <Parse/PFObject+Subclass.h>
#import "EMABOrderItem.h"
@implementation EMABOrder
@dynamic customer, orderNo, orderDate, items,orderStatus, customerNote;
+(NSString *)parseClassName {
    return kOrder;
}

-(double)total
{
    double sum = 0.00;
    if (self.items) {
        for (EMABOrderItem *item in self.items) {
            sum += [item subTotal];
        }
    }
    return sum;
}

-(NSString *)friendlyTotal {
    return [NSString stringWithFormat:@"%.2f",[self total]];
}

+(PFQuery *)basicQuery{
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query includeKey:@"items.product"];
    [query orderByDescending:@"createdAt"];
    return query;
}

+(PFQuery *)queryForCustomer:(EMABUser *)customer {
    PFQuery *query = [self basicQuery];
    [query whereKey:@"customer" equalTo:customer];
    return query;
}

+(PFQuery *)queryForCustomer:(EMABUser *)customer orderStatus:(ORDER_STATUS)status{
    PFQuery  *query = [self queryForCustomer:customer];
    [query whereKey:@"orderStatus" equalTo:@(status)];
    return query;
}


-(void)addSingleProduct:(EMABProduct *)product{
    EMABOrderItem *item = [EMABOrderItem object];
    [item setProduct:product];
    [item setQuantity:1];
    [self setItems:@[item]];
}
@end
