//
//  ProductController.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "MasterController.h"
#import "Product.h"
#import "LoadingView.h"
#import "HttpHandler.h"

@interface ProductController : MasterController <UITableViewDataSource, UITableViewDelegate, LoadingDelegate, HttpDelegate>
{
    NSInteger imageIndex;
    BOOL swiping;
    CGFloat screenWidth;
}

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyNowButton;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak, nonatomic) IBOutlet UITableView *pricesTableView;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *previousPricesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *moreImagesIndicationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageView;

@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) Product *product;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageRightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeftConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextLeftConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextRightConst;

@end
