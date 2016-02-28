//
//  ProductTypesController.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "ProductTypesController.h"
#import "ProductTypesParser.h"
#import "ProductTypeCell.h"

@implementation ProductTypesController

#define page_count 25
#define cell_height 60

@synthesize typesTableView;
@synthesize types;
@synthesize httpHandler;
@synthesize loadingView;
@synthesize selectedTypes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.languageDetails LocalString:@"Interests"];
    
    [typesTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)]];
    [typesTableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)]];
    [typesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [loadingView setDelegate:self];
    
    types = [[NSMutableArray alloc] init];
    
    NSString *typeSelectedIds = [self.userDetails product_types];
    if ([typeSelectedIds isEqualToString:@""])
        selectedTypes = [[NSMutableArray alloc] init];
    else
        selectedTypes = [[NSMutableArray alloc] initWithArray:[[self.userDetails product_types] componentsSeparatedByString:@","]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!stayHere && selectedTypes.count>0)
        [self performSegueWithIdentifier:@"ProductsSegue" sender:self];
    else if (types.count==0)
        [self getTypes];
    
    stayHere = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [typesTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (IBAction)saveBarButtonItemTapped:(UIBarButtonItem *)sender {
    [self.userDetails setProduct_types:[Common getStringForArray:selectedTypes]];
    [self performSegueWithIdentifier:@"ProductsSegue" sender:self];
}

- (void)getTypes {
    
    if (httpHandler) {
        [httpHandler cancel];
    }
    
    [(httpHandler = [[HttpHandler alloc] initWithDelegate:self])
     callMethod:PListProductTypesURIKey
     withParams:@[@"page", @"show", @"language"]
     andValues:@[[NSString stringWithFormat:@"%d", (types.count + page_count - 1) / page_count + 1], // famous ceiling trick
                 [NSString stringWithFormat:@"%d", page_count],
                 [self.languageDetails language]] andExtras:@[]];
    
    if (types.count==0) {
        [loadingView startLoadingWitMessage:@"FetchingProductTypes"];
        [typesTableView setHidden:YES];
    }
}

- (void)reload {
    [self getTypes];
}

- (void)response:(NSString *)response WithParams:(NSArray *)params {
    ProductTypesParser *parser = [[ProductTypesParser alloc] initWithJSON:response];
    if (!parser.types) {
        [loadingView stopLoadingWithError:@"FailTryAgain"];
    } else if (parser.types.count==0) {
        if (types.count==0) {
            [loadingView stopLoadingWithError:@"NoMore"];
        } else {
            [loadingView stopLoading];
            [[[UIAlertView alloc] initWithTitle:[self.languageDetails LocalString:@"ProductTypes"] message:[self.languageDetails LocalString:@"NoMore"] delegate:nil cancelButtonTitle:[self.languageDetails LocalString:@"OK"] otherButtonTitles:nil] show];
        }
    } else {
        [loadingView stopLoading];
        [types addObjectsFromArray:parser.types];
        [typesTableView setHidden:NO];
        [typesTableView reloadData];
        [typesTableView flashScrollIndicators];
    }
}

- (void)responseWithError:(NSString *)error WithParams:(NSArray *)params {
    if (types.count==0) {
        [loadingView stopLoadingWithError:@"ServerUnreachable"];
    } else {
        [[[UIAlertView alloc] initWithTitle:[self.languageDetails LocalString:@"ProductTypes"] message:[self.languageDetails LocalString:@"ServerUnreachable"] delegate:nil cancelButtonTitle:[self.languageDetails LocalString:@"OK"] otherButtonTitles:nil] show];
        [loadingView stopLoading];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTypeCell"];
    [cell.selectionBackView setCornerRadius:CGSizeMake(4, 4)];
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView willDisplayCell:(nonnull ProductTypeCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // seperator insets
    [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    ProductType *type = [types objectAtIndex:indexPath.row];
    [cell setType:type];

    if ([selectedTypes containsObject:type.type_id])
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self styleSelectionFor:cell atIndexPath:indexPath];
    
    [cell.typeLabel setText:type.type_label_plural];
    
    if (indexPath.row == types.count-2) {
        [self getTypes];
    }
}

- (void)styleSelectionFor:(ProductTypeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    BOOL selected = [[typesTableView indexPathsForSelectedRows] containsObject:indexPath];
    [cell.typeLabel setTextColor:selected?[UIColor whiteColor]:[self.stylingDetails themeColor]];
    [cell.selectionBackView setBackgroundColor:selected?[self.stylingDetails themeBlueColor]:[self.stylingDetails themeGrayColor]];
    [cell.selectionImageView setHidden:!selected];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cell_height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return types.count;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductType *type = [types objectAtIndex:indexPath.row];
    [selectedTypes removeObject:type.type_id];
    [self styleSelectionFor:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductType *type = [types objectAtIndex:indexPath.row];
    [selectedTypes addObject:type.type_id];
    [self styleSelectionFor:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
}

@end
