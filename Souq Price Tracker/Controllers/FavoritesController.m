//
//  FavoritesController.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright (c) 2016 Hasan. All rights reserved.
//

#import "FavoritesController.h"
#import "DBLayer.h"

@implementation FavoritesController

@synthesize controller;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"FavoritesEmbedSegue"]) {
        controller = segue.destinationViewController;
        controller.products = [[DBLayer database] getFavorites:NO];
    }
}

@end
