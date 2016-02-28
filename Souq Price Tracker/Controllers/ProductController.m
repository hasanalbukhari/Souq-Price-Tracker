//
//  ProductController.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "ProductController.h"
#import "PriceCell.h"
#import "ProductParser.h"
#import "Offer.h"
#import "DBLayer.h"

@implementation ProductController

@synthesize addToCartButton;
@synthesize buyNowButton;
@synthesize productImageView;
@synthesize productLabel;
@synthesize productPriceLabel;
@synthesize pricesTableView;
@synthesize product;
@synthesize loadingView;
@synthesize previousPricesLabel;
@synthesize favoriteImageView;
@synthesize moreImagesIndicationLabel;
@synthesize nextImageView;
@synthesize images;
@synthesize imageLeftConst;
@synthesize imageRightConst;
@synthesize nextLeftConst;
@synthesize nextRightConst;

#define cell_height 44

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.languageDetails LocalString:@"Interests"];
    
    [self setLocalizedText];
    
    [pricesTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)]];
    
    [loadingView setDelegate:self];
    
    // disable image swiping
    [moreImagesIndicationLabel setHidden:YES];
    nextRightConst.constant = -8;
    nextLeftConst.constant = 10000;
    [productImageView setUserInteractionEnabled:NO];
    
    [self setProductDetails];
    [self getProductPrices];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // get screen width after to be used for animating images
    screenWidth = self.view.frame.size.width;
}

- (void)setLocalizedText {
    [buyNowButton setTitle:[self.languageDetails LocalString:@"BuyNow"] forState:UIControlStateNormal];
    [addToCartButton setTitle:[self.languageDetails LocalString:@"AddToCart"] forState:UIControlStateNormal];
    [previousPricesLabel setText:[self.languageDetails LocalString:@"PreviousPrices"]];
}

- (void)setProductDetails {
    [productImageView sd_setImageWithURL:[NSURL URLWithString:[product.product_limage objectAtIndex:0]]];
    [productLabel setText:product.product_label];
    [productPriceLabel setText:[product getFormattedPrice]];
    
    [favoriteImageView setImage:[UIImage imageNamed:[[[DBLayer database] getFavorites:NO] containsObject:product]?@"product_selected_favorite":@"product_unselected_favorite"]];
}

- (IBAction)swipedLeft:(UISwipeGestureRecognizer *)sender {
    
    /* check if animating allowed
     1. images exists
     2. images are not being swiped right noew
     3. not boundery image
    */
    if (images && images.count>0 && imageIndex<images.count-1 && !swiping) {
        // increase image index
        imageIndex++;
        
        // prepare for animation, put image in the right place out of screen before animation
        nextRightConst.constant = -8;
        nextLeftConst.constant = screenWidth;
        [nextImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[images objectAtIndex:imageIndex]]];
        [self.view layoutIfNeeded];
        
        // set animation values
        nextRightConst.constant = 8;
        nextLeftConst.constant = 8;
        imageLeftConst.constant = -100;
        imageRightConst.constant = screenWidth;
        swiping = YES;
        
        // animating
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            // re-place the productImageView in the screen and nextImageView out of screen
            [productImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[images objectAtIndex:imageIndex]]];
            imageRightConst.constant = 8;
            imageLeftConst.constant = 8;
            nextRightConst.constant = -8;
            nextLeftConst.constant = screenWidth;
            [self.view layoutIfNeeded];
            swiping = NO;
        }];
    }
}

- (IBAction)swipedRight:(UISwipeGestureRecognizer *)sender {
    if (images != nil && images.count>0 && imageIndex>0 && !swiping ) {
        imageIndex--;
        
        nextLeftConst.constant = -8;
        nextRightConst.constant = screenWidth;
        [nextImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[images objectAtIndex:imageIndex]]];
        [self.view layoutIfNeeded];
        nextLeftConst.constant = 8;
        nextRightConst.constant = 8;
        imageLeftConst.constant = screenWidth;
        imageRightConst.constant = -100;
        swiping = YES;
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [productImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[images objectAtIndex:imageIndex]]];
            imageLeftConst.constant = 8;
            imageRightConst.constant = 8;
            nextRightConst.constant = -8;
            nextLeftConst.constant = screenWidth;
            [self.view layoutIfNeeded];
            swiping = NO;
        }];
    }
}

- (IBAction)favoriteGestureTapped:(UITapGestureRecognizer *)sender {
    NSMutableArray *favorites = [[DBLayer database] getFavorites:NO];
    if ([favorites containsObject:product]) {
        [favorites removeObject:product];
        [[DBLayer database] deleteItem:product];
    } else {
        [favorites addObject:product];
        [[DBLayer database] insertItem:product];
    }
    [self setProductDetails];
}

- (void)getProductPrices {
    
    // prepare parameters values
    NSString *offers_limit = @"10";
    NSString *country = @"ae";
    NSString *language = [self.languageDetails language];
    
    [[[HttpHandler alloc] initWithDelegate:self]
     callMethod:PListProductURIKey
     withParams:@[@"country", @"language", @"offers_limit", @"show_offers", @"show_attributes", @"show_variations"]
     andValues:@[product.product_id, country, language, offers_limit, @"1", @"0", @"0"] andExtras:@[]];
    
    [loadingView startLoadingWitMessage:@"FetchingProductPrices"];
}

- (void)reload {
    [self getProductPrices];
}

- (void)response:(NSString *)response WithParams:(NSArray *)params {
    ProductParser *parser = [[ProductParser alloc] initWithJSON:response];
    if (!parser.product) {
        [loadingView stopLoadingWithError:@"FailTryAgain"];
    } else if (parser.product.offers.count==0) {
        [loadingView stopLoadingWithMessage:@"NoMore"];
    } else {
        [loadingView stopLoading];
        product = parser.product;
        [self setProductDetails];
        if (product.product_limage.count > 1) {
            [moreImagesIndicationLabel setHidden:NO];
            images = product.product_limage;
            [productImageView setUserInteractionEnabled:YES];
        }
        
        // sort offers based on inserted date
        [product.offers sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
             
             Offer *offer1 = (Offer*)obj1;
             Offer *offer2 = (Offer*)obj2;
             if ([offer1 daysSinceInsertedDate] > [offer2 daysSinceInsertedDate])
                 return (NSComparisonResult)NSOrderedDescending;
             
             if ([offer1 daysSinceInsertedDate] < [offer2 daysSinceInsertedDate])
                 return (NSComparisonResult)NSOrderedAscending;
             return (NSComparisonResult)NSOrderedSame;
         }];
        
        [pricesTableView reloadData];
    }
}

- (void)responseWithError:(NSString *)error WithParams:(NSArray *)params {
    [loadingView stopLoadingWithError:@"ServerUnreachable"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceCell"];
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView willDisplayCell:(nonnull PriceCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    Offer *offer = [product.offers objectAtIndex:indexPath.row];

    [cell.priceLabel setText:[offer getFormattedPrice]];
    [cell.daysLabel setText:[offer formattedDaysSinceInsertedDate]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cell_height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return product.offers.count;
}

- (void) orientationChanged:(NSNotification *)notification
{
    screenWidth = self.view.frame.size.width;
}

@end
