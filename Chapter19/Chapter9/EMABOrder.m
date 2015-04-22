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
    double sum = 0.0;
    if (self.items) {
        for (EMABOrderItem *item in self.items) {
            sum += [item subTotal];
        }
    }
    return sum;
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

@end
