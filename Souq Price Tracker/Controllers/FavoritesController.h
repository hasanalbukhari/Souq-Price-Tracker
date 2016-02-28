//
//  FavoritesController.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright (c) 2016 Hasan. All rights reserved.
//

#import "MasterController.h"
#import "ProductsController.h"

@interface FavoritesController : MasterController

@property (nonatomic, strong) ProductsController *controller;

@end
