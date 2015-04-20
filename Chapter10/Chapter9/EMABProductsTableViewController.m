//
//  EMABProductsTableViewController.m
//  Chapter7
//
//  Created by Liangjun Jiang on 4/19/15.
//  Copyright (c) 2015 Liangjun Jiang. All rights reserved.
//

#import "EMABProductsTableViewController.h"
#import "EMABConstants.h"
#import "EMABCategory.h"
#import "EMABProduct.h"
#import "EMABProductTableViewCell.h"
#import "EMABProductDetailViewController.h"
@interface EMABProductsTableViewController()<UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, copy) NSString *keyword;
@end;

@implementation EMABProductsTableViewController


-(void)setBrand:(EMABCategory *)brand
{
    if (_brand != brand) {
        _brand = brand;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.parseClassName = kProduct;
    self.objectsPerPage = 20;
    self.paginationEnabled = YES;
    self.pullToRefreshEnabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (PFQuery *)queryForTable {
    PFQuery *query = [EMABProduct queryForCategory:self.brand];

    if (self.keyword) {
        query = [EMABProduct queryForCategory:self.brand keyword:self.keyword];
    }
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    return query;
}

#pragma mark - Table View

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (EMABProductTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(EMABProduct *)object{
    EMABProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    if (indexPath.row == [[self objects] count]) {
        cell.textLabel.text = NSLocalizedString(@"Load More...", @"");
    } else {
        [cell configureItem:object];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [[self objects] count]) {
        [self loadNextPage];
    } else {
        EMABProductDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EMABProductDetailViewController"];
        [viewController setProduct:(EMABProduct*)[self objectAtIndexPath:indexPath]];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - searchbar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar.text length] > 0) {
        [searchBar resignFirstResponder];
        self.keyword = searchBar.text;
        [self clear];
        [self loadObjects];
    }
}

#pragma  mark - scrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
@end
