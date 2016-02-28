//
//  ProductsParser.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "ProductsParser.h"

@implementation ProductsParser

@synthesize products;

- (id)initWithJSON:(NSString *)json {
    
    if ((self = [super init])) {
        
        products = [[NSMutableArray alloc] init];
        
        @try {
            
            NSError *e = nil;
            NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:kNilOptions
                                                                       error:&e];
            
            NSDictionary *proDict = [[jsonDict valueForKey:@"data"] valueForKey:@"products"];
            for (NSDictionary *item in proDict) {
                Product *product = [[Product alloc] init];
                
                [product setProduct_currency:[item valueForKey:@"currency"]];
                [product setProduct_id:[item valueForKey:@"id"]];
                [product setProduct_label:[item valueForKey:@"label"]];
                [product setProduct_price:[[item valueForKey:@"msrp"] integerValue]];
                [product setProduct_formatted_price:[item valueForKey:@"msrp_formatted"]];
                [product setProduct_offer_price:[[item valueForKey:@"offer_price"] integerValue]];
                [product setProduct_offer_formatted_price:[item valueForKey:@"offer_price_formatted"]];
                [product setProduct_rate:[item valueForKey:@"rating"]];
                [product setProduct_rate_count:[item valueForKey:@"ratings_count"]];
                
                NSDictionary *limagesDict = [[item valueForKey:@"images"] valueForKey:@"L"];
                NSDictionary *mimagesDict = [[item valueForKey:@"images"] valueForKey:@"M"];

                product.product_limage = [[NSMutableArray alloc] init];
                for (NSDictionary *imageItem in limagesDict) {
                    [product.product_limage addObject:imageItem];
                }
                
                product.product_mimage = [[NSMutableArray alloc] init];
                for (NSDictionary *imageItem in mimagesDict) {
                    [product.product_mimage addObject:imageItem];
                }
                
                [products addObject:product];
            }
            
        } @catch (NSException *exception) {
            products = nil;
            DDLogVerbose(@"Products ::::: Json Parsing Exception ::::: %@", [exception debugDescription]);
        }
        @finally {
            
        }
    }
    
    return self;
}

@end
