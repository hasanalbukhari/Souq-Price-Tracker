//
//  ProductParser.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "ProductParser.h"
#import "Offer.h"

@implementation ProductParser

@synthesize product;

- (id)initWithJSON:(NSString *)json {
    
    if ((self = [super init])) {
        
        product = [[Product alloc] init];
        
        @try {
            
            NSError *e = nil;
            NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:kNilOptions
                                                                       error:&e];
            
            NSDictionary *proDict = [jsonDict valueForKey:@"data"];
                
            [product setProduct_currency:[proDict valueForKey:@"currency"]];
            [product setProduct_id:[proDict valueForKey:@"id"]];
            [product setProduct_label:[proDict valueForKey:@"label"]];
            [product setProduct_price:[[proDict valueForKey:@"msrp"] integerValue]];
            [product setProduct_formatted_price:[proDict valueForKey:@"msrp_formatted"]];
            [product setProduct_offer_price:[[proDict valueForKey:@"offer_price"] integerValue]];
            [product setProduct_offer_formatted_price:[proDict valueForKey:@"offer_price_formatted"]];
            [product setProduct_rate:[proDict valueForKey:@"rating"]];
            [product setProduct_rate_count:[proDict valueForKey:@"ratings_count"]];
                
            NSDictionary *limagesDict = [[proDict valueForKey:@"images"] valueForKey:@"L"];
            NSDictionary *mimagesDict = [[proDict valueForKey:@"images"] valueForKey:@"M"];
            
            product.product_limage = [[NSMutableArray alloc] init];
            for (NSDictionary *imageItem in limagesDict) {
                [product.product_limage addObject:imageItem];
            }
            
            product.product_mimage = [[NSMutableArray alloc] init];
            for (NSDictionary *imageItem in mimagesDict) {
                [product.product_mimage addObject:imageItem];
            }
            
            NSDictionary *offersDict = [proDict valueForKey:@"offers"];
            for (NSDictionary *item in offersDict) {
                Offer *offer = [[Offer alloc] init];
                
                [offer setOffer_id:[item valueForKey:@"id"]];
                [offer setOffer_currency:[item valueForKey:@"currency"]];
                [offer setOffer_formated_price:[item valueForKey:@"price_formatted"]];
                [offer setOffer_inserted_date:[item valueForKey:@"date_inserted"]];
                [offer setOffer_price:[[item valueForKey:@"price"] integerValue]];
                
                [product.offers addObject:offer];
            }
            
        } @catch (NSException *exception) {
            product = nil;
            DDLogVerbose(@"Product ::::: Json Parsing Exception ::::: %@", [exception debugDescription]);
        }
        @finally {
            
        }
    }
    
    return self;
}

@end
