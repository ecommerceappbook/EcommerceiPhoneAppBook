//
//  EMABBagTableViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABBagTableViewController.h"
#import "EMABOrderItemTableViewCell.h"
#import "EMABConstants.h"
#import "EMABUser.h"
#import "EMABOrder.h"
#import "EMABOrderItem.h"
#import "EMABProduct.h"
@interface EMABBagTableViewController()
@property (nonatomic, weak) IBOutlet UILabel *ordeNoLabel;
@property (nonatomic, weak) IBOutlet UILabel *ordeDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalLabel;

@property (nonatomic, strong) EMABOrder *order;
@end

@implementation EMABBagTableViewController

-(void)viewDidLoad
{
    [self queryForUnfinishedOrder];
}




-(void)queryForUnfinishedOrder {
    PFQuery *orderQuery = [EMABOrder queryForCustomer:[EMABUser currentUser] orderStatus:ORDER_NOT_MADE];
    [orderQuery getFirstObjectInBackgroundWithBlock:^(PFObject *order, NSError *error){
        if (!error) {
            self.order = (EMABOrder *)order;
        }
    }];
}
#pragma mark - IBAction
-(IBAction)onPayWithCreditCard:(id)sender{
    
    
}

-(IBAction)onApplePay:(id)sender{
    
    
}

#pragma mark - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.order.items count];
}


- (EMABOrderItemTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMABOrderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderItem" forIndexPath:indexPath];
 
    if (self.order) [cell configureItem:self.order.items[indexPath.row]];
    return cell;
}


@end
