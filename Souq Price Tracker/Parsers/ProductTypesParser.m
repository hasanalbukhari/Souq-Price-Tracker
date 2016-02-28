//
//  ProductTypesParser.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "ProductTypesParser.h"

@implementation ProductTypesParser

@synthesize types;

- (id)initWithJSON:(NSString *)json {
    
    if ((self = [super init])) {
        
        types = [[NSMutableArray alloc] init];
        
        @try {
            
            NSError *e = nil;
            NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:kNilOptions
                                                                       error:&e];
            
            NSDictionary *typesDict = [jsonDict valueForKey:@"data"];
            for (NSDictionary *item in typesDict) {
                ProductType *type = [[ProductType alloc] init];
                
                [type setType_id:[item valueForKey:@"id"]];
                [type setType_label_plural:[item valueForKey:@"label_plural"]];
                [type setType_label_singular:[item valueForKey:@"label_singular"]];
                [type setType_link:[item valueForKey:@"link"]];

                [types addObject:type];
            }
            
        } @catch (NSException *exception) {
            types = nil;
            DDLogVerbose(@"Product Types ::::: Json Parsing Exception ::::: %@", [exception debugDescription]);
        }
        @finally {
            
        }
    }
    
    return self;
}

@end
