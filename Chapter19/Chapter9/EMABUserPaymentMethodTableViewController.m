//
//  EMABUserPaymentMethodTableViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABUserPaymentMethodTableViewController.h"
#import "EMABConstants.h"
#import "EMABUser.h"
#import "EMABPaymentMethod.h"

@implementation EMABUserPaymentMethodTableViewController


- (void)awakeFromNib {
    [super awakeFromNib];
    self.parseClassName = kPaymentMethod;
    self.objectsPerPage = 10;
    self.paginationEnabled = YES;
    self.pullToRefreshEnabled = YES;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [EMABPaymentMethod queryForOwner:[EMABUser currentUser]];
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    return query;
}

#pragma mark - IBAction
-(IBAction)onAdd:(id)sender
{
    
    
}

#pragma mark - UITableView Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(EMABPaymentMethod *)object{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentMethodCell" forIndexPath:indexPath];
    if (indexPath.row == [[self objects] count]) {
        cell.textLabel.text = NSLocalizedString(@"Load More...", @"");
    } else {
        cell.textLabel.text = [object friendlyCreditCardNumber];
        cell.detailTextLabel.text = [object friendlyExpirationMonthYear];
    }
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMABPaymentMethod *paymentMethod = (EMABPaymentMethod *)[self objectAtIndexPath:indexPath];
        [paymentMethod deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self loadObjects];
            }
        }];
    }
}


@end
