//
//  ProductType.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/27/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductType : NSObject

@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *type_label_plural;
@property (nonatomic, strong) NSString *type_label_singular;
@property (nonatomic, strong) NSString *type_link;

@end
