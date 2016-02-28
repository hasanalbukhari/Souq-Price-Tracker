//
//  Offer.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Offer : NSObject

@property (nonatomic, strong) NSString *offer_id;
@property (nonatomic, assign) NSInteger offer_price;
@property (nonatomic, strong) NSString *offer_formated_price;
@property (nonatomic, strong) NSString *offer_inserted_date;
@property (nonatomic, strong) NSString *offer_currency;

- (NSString *)getFormattedPrice;
- (NSString *)formattedDaysSinceInsertedDate;
- (NSInteger)daysSinceInsertedDate;

@end
