//
//  ProductTypesParser.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductType.h"

@interface ProductTypesParser : NSObject

@property (nonatomic, strong) NSMutableArray *types;

- (id)initWithJSON:(NSString *)json;

@end
