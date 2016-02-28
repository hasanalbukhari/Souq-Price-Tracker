//
//  ProductsController.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "ProductsController.h"
#import "Product.h"
#import "ProductsParser.h"
#import "ProductCell.h"
#import "DBLayer.h"
#import "ProductController.h"

@implementation ProductsController

@synthesize productsCollectionView;
@synthesize loadingView;
@synthesize products;
@synthesize httpHandler;
@synthesize favorites;
@synthesize displayTypeButton;
@synthesize searchQuery;
@synthesize searchBar;
@synthesize tempProducts;
@synthesize headerLabel;
@synthesize searchBarButton;

#define page_count 25
#define display_type_button_tag 101
#define header_label_tag 102
#define list_display_cell_height 100

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the settings icon to the tabbar navigation left item.
    self.tabBarController.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem;
    
    // set the loading view delegate.
    [loadingView setDelegate:self];
    
    // if products exists then the products passed to this controller. (This is a favorite display)
    if (products) {
        displayfavorites = YES;
    } else {
        
        products = [[NSMutableArray alloc] init];
        
        // get favorites from databse table.
        favorites = [[DBLayer database] getFavorites:NO];

        // init search query. it could be used.
        searchQuery = @"";
    }
    
    [self getProducts];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // reload data to update favorites.
    [productsCollectionView reloadData];
    
    // show appropriate navigation bar content.
    if (displayfavorites) {
        self.tabBarController.navigationItem.titleView = nil;
        self.tabBarController.navigationItem.rightBarButtonItem = nil;
        self.tabBarController.title = [self.languageDetails LocalString:@"Favorites"];
    } else {
        [self hideSearchBar];
        self.tabBarController.title = [self.languageDetails LocalString:@"Products"];
    }
}

- (void)hideSearchBar {
    if (!searchBarButton)
        searchBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar)];
    self.tabBarController.navigationItem.rightBarButtonItem = searchBarButton;
    self.tabBarController.navigationItem.titleView = nil;
}

- (void)showSearchBar {
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.titleView = self.navigationItem.titleView;
    
    [searchBar becomeFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // if search proccess just started. saved user products.
    if ([searchQuery isEqualToString:@""]) {
        
        // check if products contains search results or user products.
        if (!tempProducts)
            tempProducts = products;
        
        products = [[NSMutableArray alloc] init];
        [productsCollectionView reloadData];
    }
    
    // if search text deleted. restore user products.
    if ([searchText isEqualToString:@""]) {
        
        [self restoreUserProducts];
        
        // if no products to show. hide collection view.
        if (products && products.count>0)
        {
            [productsCollectionView setHidden:NO];
            [loadingView stopLoading];
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self hideSearchBar];
    self.searchBar.text = @"";
    [self restoreUserProducts];
    
    [self.searchBar resignFirstResponder];
    if (products && products.count>0)
    {
        [productsCollectionView setHidden:NO];
        [loadingView stopLoading];
    }
}

/* when user stop searching. use this function to show the products
 which been displayed before the search process started */
- (void)restoreUserProducts {
    searchQuery = @"";
    if (tempProducts) {
        products = tempProducts;
        tempProducts = nil;
    }
    [productsCollectionView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self hideSearchBar];
    searchQuery = self.searchBar.text;
    [self.searchBar resignFirstResponder];
    
    // show empty collection view during the search proccess.
    // clear old search results.
    products = [[NSMutableArray alloc] init];
    [productsCollectionView reloadData];
    
    // search
    [self getProducts];
}

- (void)getProducts {
    
    // don't get products in the following situations:
    // 1. this the favorites controller
    // 2. Or, no more products to load
    if (displayfavorites || (products.count>0 && products.count % page_count != 0))
        return;
    
    // 3. no search query and no product types selected. (hide collection view)
    if ([[self.userDetails product_types] isEqualToString:@""] && [searchQuery isEqualToString:@""])
    {
        [productsCollectionView setHidden:YES];
        [loadingView stopLoadingWithMessage:@"NoTypesSelected"];
        return;
    }
    
    // prepare parameters values
    NSString *q = searchQuery;
    NSString *page = [NSString stringWithFormat:@"%d", (products.count + page_count - 1) / page_count + 1];
    NSString *show = [NSString stringWithFormat:@"%d", page_count];
    NSString *country = @"ae";
    NSString *language = [self.languageDetails language];
    NSString *product_types = [self.userDetails product_types];
    NSString *show_attributes = @"0";
    
    // cancel current connection.
    if (httpHandler) {
        [httpHandler cancel];
    }
    
    // consume web service
    [(httpHandler=[[HttpHandler alloc] initWithDelegate:self]) callMethod:PListProductsURIKey
     withParams:@[@"q", @"page", @"show", @"country", @"language", @"product_types", @"show_attributes"]
     andValues:@[q, page, show, country,language, product_types, show_attributes]
     andExtras:@[]];
    
    // if no products currently displayed. show the loading view.
    if (products.count==0) {
        [loadingView startLoadingWitMessage:@"FetchingProducts"];
        [productsCollectionView setHidden:YES];
    }
}

// loading view delegate method. for the reload button in the loading view.
- (void)reload {
    searchQuery = @"";
    [self getProducts];
}

- (void)response:(NSString *)response WithParams:(NSArray *)params {
    ProductsParser *parser = [[ProductsParser alloc] initWithJSON:response];
    if (!parser.products) {
        [loadingView stopLoadingWithError:@"FailTryAgain"];
    } else if (parser.products.count==0) {
        if (products.count==0) {
            [loadingView stopLoadingWithError:@"NoMore"];
        } else {
            [loadingView stopLoading];
        }
    } else {
        [loadingView stopLoading];
        [products addObjectsFromArray:parser.products];
        [productsCollectionView setHidden:NO];
        [productsCollectionView reloadData];
        // flash scroll bar. when it a load more operation.
        [productsCollectionView flashScrollIndicators];
    }
}

- (void)responseWithError:(NSString *)error WithParams:(NSArray *)params {
    if (products.count==0) {
        [loadingView stopLoadingWithError:@"ServerUnreachable"];
    } else {
        [[[UIAlertView alloc] initWithTitle:[self.languageDetails LocalString:@"Product"] message:[self.languageDetails LocalString:@"ServerUnreachable"] delegate:nil cancelButtonTitle:[self.languageDetails LocalString:@"OK"] otherButtonTitles:nil] show];
        [loadingView stopLoading];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:listDisplay?@"ListProductCell":@"ProductCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(ProductCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product = [products objectAtIndex:indexPath.row];
    [cell setProduct:product];
    
    // style the favorite button. (the heart icon)
    [cell.favoriteButton setTintColor:[self isFavorite:product]?[UIColor whiteColor]:[UIColor grayColor]];
    
    [cell.productLabel setText:product.product_label];
    [cell.priceLabel setText:[product getFormattedPrice]];
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:[product.product_mimage objectAtIndex:0]]];
    
    [cell.favoriteButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [cell.favoriteButton addTarget:self action:@selector(favoriteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // load more products
    if (indexPath.row == products.count-2) {
        [self getProducts];
    }
}

- (BOOL)isFavorite:(Product *)product {
    // if this is a favorite display. all products are favorites.
    if (displayfavorites)
        return YES;
    
    // otherwise, check if the product exists in the favorites array.
    return [favorites containsObject:product];
}

- (IBAction)favoriteButtonTapped:(UIButton *)button {
    ProductCell *cell = (ProductCell *)[self getCellForView:button];
    
    // if the product is a favorite, remove it. if not, add it.
    if ([self isFavorite:cell.product]) {
        
        // if this is a favorite display, remove it from products array.
        if (displayfavorites) {
            [products removeObject:cell.product];
            [productsCollectionView deleteItemsAtIndexPaths:@[[productsCollectionView indexPathForCell:cell]]];
        } else {
            [favorites removeObject:cell.product];
        }
        
        // remove product from favorites database table.
        [[DBLayer database] deleteItem:cell.product];
        
        // fix tint color for the favorite button (the heart icon)
        [button setTintColor:[UIColor grayColor]];
    } else {
        
        // add object to favorites array and database table.
        [favorites addObject:cell.product];
        [[DBLayer database] insertItem:cell.product];
        
        // fix tint color for the favorite button (the heart icon)
        [button setTintColor:[UIColor whiteColor]];
    }
}

- (UICollectionViewCell *)getCellForView:(UIView *)view {
    // this approach garanties to return the cell. regardless the changes of the cell structure on storyboad.
    while (view.superview) {
        view = view.superview;
        if ([view isKindOfClass:UICollectionViewCell.class])
            break;
    }
    return (UICollectionViewCell *)view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Product *product = [products objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ProductSegue" sender:product];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProductSegue"])
        ((ProductController *)segue.destinationViewController).product = sender;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // the default size is the size of the grid display type cell
    CGSize defaultSize = [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
    CGFloat left_padding = [(UICollectionViewFlowLayout*)collectionViewLayout sectionInset].left;
    CGFloat right_padding = [(UICollectionViewFlowLayout*)collectionViewLayout sectionInset].left;
    CGFloat actualSpaceWidth = collectionView.frame.size.width - left_padding - right_padding;
    
    // if the display type is list. then, the cell size is equal to the (collection_view_width - margins).
    // and the height can be any constant value.
    if (listDisplay)
        return CGSizeMake(actualSpaceWidth, list_display_cell_height);
    
    // grid type display.
    CGFloat ratio = defaultSize.height / defaultSize.width;
    CGFloat minSpace = [(UICollectionViewFlowLayout*)collectionViewLayout minimumInteritemSpacing];
    
    CGFloat maxCellWidth = 197;
    // determine the number of cells in row if we maximized the cell width.
    NSInteger maxCellsInRow  = actualSpaceWidth / maxCellWidth;
    
    // minimum cells in row should be >= 2
    NSInteger cellsInRow = MAX(maxCellsInRow, 2);
    
    // calculate new cell width and height.
    CGFloat newWidth = (actualSpaceWidth - (cellsInRow-1)*minSpace) / cellsInRow;
    CGFloat newHeight = newWidth * ratio;
    
    return CGSizeMake(newWidth, newHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return products.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionViews viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // we have only one supplementary view. which contains the display type button and header label.
    UICollectionReusableView *reusableView = [collectionViews dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    headerLabel = (UILabel *)[reusableView viewWithTag:header_label_tag];
    displayTypeButton = (UIButton *)[reusableView viewWithTag:display_type_button_tag];
    
    if (displayfavorites)
        headerLabel.text = [self.languageDetails LocalString:@"Favorites"];
    else if ([searchQuery isEqualToString:@""])
        headerLabel.text = [self.languageDetails LocalString:@"NewArrivals"];
    else
        headerLabel.text = searchQuery;
    
    [displayTypeButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [displayTypeButton addTarget:self action:@selector(displayTypeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [displayTypeButton setImage:[UIImage imageNamed:listDisplay?@"grid":@"list"] forState:UIControlStateNormal];
    
    return reusableView;
}

- (IBAction)displayTypeButtonTapped:(UIButton *)button {
    // change display type (list/grid)
    listDisplay = !listDisplay;
    [displayTypeButton setImage:[UIImage imageNamed:listDisplay?@"grid":@"list"] forState:UIControlStateNormal];
    [productsCollectionView reloadData];
}

- (IBAction)settingsButtonTapped:(UIBarButtonItem *)sender {
    // go back to the types picker view controller
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) orientationChanged:(NSNotification *)notification
{
    // reload data to increase/decrease number of cells in row if applicable.
    [productsCollectionView reloadData];
}

@end
