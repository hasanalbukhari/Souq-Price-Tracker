//
//  DBLayer.h
//  Watershade
//
//  Created by Hasan S. Al-Bukhari on 10/27/14.
//  Copyright (c) 2015 Watershade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Product.h"

@interface DBLayer : NSObject {
    sqlite3 *_database;
    NSMutableArray *items;
}

+ (DBLayer*)database;

- (NSMutableArray *)getFavorites:(BOOL)force_reload;
- (BOOL)deleteItem:(Product *)product;
- (BOOL)insertItem:(Product *)product;

@end
