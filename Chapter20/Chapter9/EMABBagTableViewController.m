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
#import "EMABNoteViewController.h"
#import "EMABUserProfileTableViewController.h"

@interface EMABBagTableViewController(){
    BOOL shouldHide;
}
@property (nonatomic, weak) IBOutlet UILabel *ordeNoLabel;
@property (nonatomic, weak) IBOutlet UILabel *ordeDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalLabel;
@property (nonatomic, strong) UIView *noItemsCoverView;
@property (nonatomic, strong) UILabel *noItemsInfoLabel;

@property (nonatomic, strong) EMABOrder *order;
@end

@implementation EMABBagTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryForUnfinishedOrder];
}

-(void)viewDidLoad
{
    shouldHide = false;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (self.order && self.order.isDirty) {
        [self.order saveInBackground];
    }
}

-(void)queryForUnfinishedOrder {
    PFQuery *orderQuery = [EMABOrder queryForCustomer:[EMABUser currentUser] orderStatus:ORDER_NOT_MADE];
    [orderQuery getFirstObjectInBackgroundWithBlock:^(PFObject *order, NSError *error){
        if (!error) {
            self.order = (EMABOrder *)order;
            self.ordeNoLabel.text = @"";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            self.ordeDateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
            self.totalLabel.text = [self.order friendlyTotal];
            [self.tableView reloadData];
        } else {
            shouldHide = true;
        }
    }];
}

#pragma mark - Handle No Items
-(void)handleNoItems{
    if (shouldHide) {
        self.noItemsCoverView.hidden = !shouldHide;
        self.noItemsInfoLabel.hidden  = !shouldHide;
        [self.noItemsCoverView addSubview:self.noItemsInfoLabel];
        [self.view addSubview:self.noItemsCoverView];
        [self.view bringSubviewToFront:self.noItemsCoverView];
        self.navigationItem.rightBarButtonItem.enabled = false;
    }
}


#pragma mark - IBAction
-(IBAction)onNote:(id)sender {
    EMABNoteViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EMABNoteViewController"];
    viewController.cancelBlock = ^(EMABNoteViewController *viewController){
        
    };
    viewController.finishBlock = ^(EMABNoteViewController *viewController, NSString *note){
        self.order.customerNote = note;
    };
}

-(IBAction)onPayWithCreditCard:(id)sender{
    
    if ([[EMABUser currentUser] isShippingAddressCompleted]) {
        
    } else {
        EMABUserProfileTableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EMABUserProfileTableViewController"];
        
    }

}

-(IBAction)onApplePay:(id)sender{
    
    
}

-(IBAction)onStepper:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    NSInteger index = stepper.tag - 100;
    NSMutableArray *orderItems = [NSMutableArray arrayWithArray:self.order.items];
    EMABOrderItem *orderItem = orderItems[index];
    orderItem.quantity = (int)stepper.value;
    
    if ((int)stepper.value == 0) {
        [orderItems removeObjectAtIndex:index];
    } else {
        [orderItems replaceObjectAtIndex:index withObject:orderItem];
    }
    
    if ([orderItems count] == 0) {
        shouldHide = nil;
        [self handleNoItems];
        [self.order deleteInBackgroundWithBlock:^(BOOL success, NSError *error){
            if (!error) {
                // we let us know
            }
        }];
    } else {
        self.order.items = [orderItems copy];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        self.totalLabel.text = [self.order friendlyTotal];
    }
    
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
 
    if (self.order) [cell configureItem:self.order.items[indexPath.row] tag:indexPath.row];
    return cell;
}

#pragma  mark - Setters
-(UIView *)noItemsCoverView {
    if (!_noItemsCoverView) {
        self.noItemsCoverView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        self.noItemsCoverView.backgroundColor  = [UIColor whiteColor];
        self.noItemsCoverView.hidden = YES;
    }
    
    return _noItemsCoverView;
    
}

-(UILabel *)noItemsInfoLabel {
    
    if (_noItemsInfoLabel) {
        self.noItemsInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 80.0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        self.noItemsInfoLabel.numberOfLines = 0;
        self.noItemsInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.noItemsInfoLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.noItemsInfoLabel.hidden = YES;
        self.noItemsInfoLabel.text = NSLocalizedString(@"There is no items in your bag.", @"There is no items in your bag.");
    }
    
    return _noItemsInfoLabel;
}

@end
