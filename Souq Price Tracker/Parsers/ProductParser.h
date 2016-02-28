//
//  ProductParser.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/28/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductParser : NSObject

@property (nonatomic, strong) Product *product;

- (id)initWithJSON:(NSString *)json;

@end
