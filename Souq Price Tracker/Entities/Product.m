//
//  Product.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "Product.h"
#import "DBLayer.h"

@implementation Product

@synthesize product_currency;
@synthesize product_id;
@synthesize product_limage;
@synthesize product_mimage;
@synthesize product_label;
@synthesize product_price;
@synthesize product_formatted_price;
@synthesize product_offer_price;
@synthesize product_offer_formatted_price;
@synthesize product_rate;
@synthesize product_rate_count;
@synthesize offers;

- (id)init {
    if (self = [super init]) {
        product_currency = @"";
        product_id = @"";
        product_limage = [[NSMutableArray alloc] init];
        product_mimage = [[NSMutableArray alloc] init];
        product_label = @"";
        product_price = 0;
        product_formatted_price = @"";
        product_offer_price = 0;
        product_offer_formatted_price = @"";
        product_rate = @"";
        product_rate_count = @"";
        offers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)getFormattedPrice {
    
    NSString *formattedPrice = product_offer_formatted_price?product_offer_formatted_price:product_formatted_price;
    
    if (!formattedPrice)
        formattedPrice = [NSString stringWithFormat:@"%ld %@",
                          (long)(product_offer_price?product_offer_price:product_price),
                          [product_currency uppercaseString]];
    
    return formattedPrice;
}

- (BOOL)isEqual:(id)object {
    Product *pro = object;
    return [product_id isEqualToString:pro.product_id];
}

@end
