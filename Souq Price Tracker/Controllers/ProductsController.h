//
//  ProductsController.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "MasterController.h"
#import "HttpHandler.h"
#import "LoadingView.h"

@interface ProductsController : MasterController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, HttpDelegate, LoadingDelegate, UISearchBarDelegate>
{
    BOOL listDisplay;
    BOOL displayfavorites;
}

@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) UIBarButtonItem *searchBarButton;

@property (strong, nonatomic) HttpHandler *httpHandler;
@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSMutableArray *tempProducts;
@property (strong, nonatomic) NSMutableArray *favorites;

@property (strong, nonatomic) UIButton *displayTypeButton;
@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) NSString *searchQuery;

@end
