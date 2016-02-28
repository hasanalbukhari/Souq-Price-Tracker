//
//  Product.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *product_currency;
@property (nonatomic, strong) NSString *product_id;
@property (nonatomic, strong) NSMutableArray *product_limage;
@property (nonatomic, strong) NSMutableArray *product_mimage;
@property (nonatomic, strong) NSString *product_label;
@property (nonatomic, assign) NSInteger product_price;
@property (nonatomic, strong) NSString *product_formatted_price;
@property (nonatomic, assign) NSInteger product_offer_price;
@property (nonatomic, strong) NSString *product_offer_formatted_price;
@property (nonatomic, strong) NSString *product_rate;
@property (nonatomic, strong) NSString *product_rate_count;
@property (nonatomic, strong) NSMutableArray *offers;

- (NSString *)getFormattedPrice;

@end
