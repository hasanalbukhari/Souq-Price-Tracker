//
//  ProductTypeCell.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornersView.h"
#import "ProductType.h"

@interface ProductTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectionImageView;
@property (weak, nonatomic) IBOutlet RoundedCornersView *selectionBackView;
@property (strong, nonatomic) ProductType *type;

@end
