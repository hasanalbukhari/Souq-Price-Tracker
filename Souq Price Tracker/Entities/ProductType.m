//
//  ProductType.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "ProductType.h"

@implementation ProductType

@synthesize type_label_plural;
@synthesize type_label_singular;
@synthesize type_link;
@synthesize type_id;

- (id)init {
    if (self = [super init]) {
        type_link = @"";
        type_label_plural = @"";
        type_label_singular = @"";
        type_id = @"";
    }
    return self;
}

@end
