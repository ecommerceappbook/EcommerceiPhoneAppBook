//
//  EMABOrder.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABOrder.h"
#import  <Parse/PFObject+Subclass.h>
#import "EMABConstants.h"
@implementation EMABOrder

+(NSString *)parseClassName {
    return kOrder;
}

+(PFQuery *)basicQuery{
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    
    return query;
    
}
@end
