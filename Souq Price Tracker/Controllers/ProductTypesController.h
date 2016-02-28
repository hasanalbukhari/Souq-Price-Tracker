//
//  ProductTypesController.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "MasterController.h"
#import "HttpHandler.h"
#import "LoadingView.h"

@interface ProductTypesController : MasterController <UITableViewDataSource, UITableViewDelegate, HttpDelegate, LoadingDelegate>
{
    BOOL stayHere;
}

@property (weak, nonatomic) IBOutlet UITableView *typesTableView;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;

@property (strong, nonatomic) HttpHandler *httpHandler;
@property (strong, nonatomic) NSMutableArray *types;
@property (strong, nonatomic) NSMutableArray *selectedTypes;

@end
