//
//  EMABOrder.h
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import <Parse/Parse.h>
#import "EMABConstants.h"
@class EMABOrderItem;
@class EMABUser;
@interface EMABOrder : PFObject<PFSubclassing>
@property (nonatomic, strong) EMABUser *customer;
@property (nonatomic, assign) int64_t orderNo;
@property (nonatomic, assign) NSDate *orderDate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) ORDER_STATUS orderStatus;
@property (nonatomic, assign) NSString *customerNote;
-(double)total;
+(PFQuery *)basicQuery;
+(PFQuery *)queryForCustomer:(EMABUser *)customer;
+(PFQuery *)queryForCustomer:(EMABUser *)customer orderStatus:(ORDER_STATUS)status;
@end
