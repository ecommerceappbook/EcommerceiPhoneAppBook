//
//  EMABPaymentMethod.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABPaymentMethod.h"
#import <Parse/PFObject+Subclass.h>
#import "EMABUser.h"
#import "EMABConstants.h"
@implementation EMABPaymentMethod
@dynamic type,lastFourDigit, expirationMonth, expirationYear,stripeCustomerId, owner;

+(NSString *)parseClassName
{
    return kPaymentMethod;
}

-(NSString *)friendlyCreditCardNumber{
    return @"";
}

-(NSString *)friendlyExpirationMonthYear{
    return [NSString stringWithFormat:@"%lld/%lld",self.expirationMonth, self.expirationYear];
}
+(PFQuery *)basicQuery{
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query orderByDescending:@"createdAt"];
    return query;
}

+(PFQuery *)queryForOwner:(EMABUser *)owner{
    PFQuery *query = [self basicQuery];
    [query whereKey:@"owner" equalTo:owner];
    return query;
}
@end
