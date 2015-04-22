//
//  EMABUserFavoriteHistoryTableViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABUserFavoriteHistoryTableViewController.h"
#import "EMABConstants.h"
#import "EMABFavoriteProduct.h"
#import "EMABProduct.h"
#import "EMABUser.h"
#import "EMABProductTableViewCell.h"
#import "EMABProductDetailViewController.h"

@implementation EMABUserFavoriteHistoryTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.parseClassName = kProduct;
    self.objectsPerPage = 10;
    self.paginationEnabled = YES;
    self.pullToRefreshEnabled = YES;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [EMABFavoriteProduct queryForCustomer:[EMABUser currentUser]];
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    return query;
}

#pragma mark - UITableView Datasource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (EMABProductTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(EMABFavoriteProduct *)object{
    EMABProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    if (indexPath.row == [[self objects] count]) {
        cell.textLabel.text = NSLocalizedString(@"Load More...", @"");
    } else {
        [cell configureItem:object.product];
    }
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMABFavoriteProduct *fProduct = (EMABFavoriteProduct *)[self objectAtIndexPath:indexPath];
        [fProduct deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self loadObjects];
            }
        }];
    }
}


#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [[self objects] count]) {
        [self loadNextPage];
    } else {
        EMABProductDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EMABProductDetailViewController"];
        [viewController setProduct:(EMABProduct*)[self objectAtIndexPath:indexPath]];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}




@end
