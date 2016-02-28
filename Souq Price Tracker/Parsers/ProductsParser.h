//
//  ProductsParser.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductsParser : NSObject

@property (nonatomic, strong) NSMutableArray *products;

- (id)initWithJSON:(NSString *)json;

@end
