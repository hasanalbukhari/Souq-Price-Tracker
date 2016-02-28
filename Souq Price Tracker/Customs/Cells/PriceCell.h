//
//  PriceCell.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;

@end
