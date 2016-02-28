//
//  Offer.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "Offer.h"

@implementation Offer

@synthesize offer_formated_price;
@synthesize offer_id;
@synthesize offer_inserted_date;
@synthesize offer_price;
@synthesize offer_currency;

- (id)init {
    if (self = [super init]) {
        offer_formated_price = @"";
        offer_id = @"";
        offer_inserted_date = @"";
        offer_price = 0;
        offer_currency = @"";
    }
    return self;
}

- (NSString *)getFormattedPrice {
    
    NSString *formattedPrice = offer_formated_price;
    
    if (!formattedPrice)
        formattedPrice = [NSString stringWithFormat:@"%ld %@",
                          (long)(offer_price),
                          [offer_currency uppercaseString]];
    
    return formattedPrice;
}

- (NSInteger)daysSinceInsertedDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *insertedDate = [formatter dateFromString:offer_inserted_date];
    
    NSTimeInterval secondsBetween = [[NSDate date] timeIntervalSinceDate:insertedDate];
    
    int numberOfDays = secondsBetween / 86400;
    return numberOfDays;
}

- (NSString *)formattedDaysSinceInsertedDate {
    NSInteger numberOfDays = [self daysSinceInsertedDate];
    
    LanguageDetails *ld = [((Singlton *)[Singlton singlton]) languageDetails];
    return numberOfDays == 0 ? [ld LocalString:@"LessThanDay"] : [NSString stringWithFormat:[ld LocalString:@"DaysAgo"], numberOfDays];
}

@end
