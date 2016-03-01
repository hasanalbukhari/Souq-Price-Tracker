//
//  DBLayer.m
//  Watershade
//
//  Created by Hasan S. Al-Bukhari on 10/27/14.
//  Copyright (c) 2015 watershade. All rights reserved.
//

#import "DBLayer.h"
#import "Common.h"

@implementation DBLayer

#define DataBaseName @"souq.db"

+ (DBLayer*)database {
    static DBLayer *_database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _database = [[DBLayer alloc] init];
    });
    return _database;
}

- (id)init {
    if ((self = [super init])) {

        @try {
            
            [self createDatabase];
            
            NSURL *libraryDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSString *sqLiteDb = [[libraryDirectoryURL URLByAppendingPathComponent:DataBaseName] path];
            
            if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
                DDLogVerbose(@"Failed to open database!");
                DDLogVerbose(@"Failed to open database at with error %s", sqlite3_errmsg(_database));
            }
        }
        @catch (NSException *exception) {
            DDLogVerbose(@"Couldn't open database.");
        }
    }
    return self;
}

- (void)createDatabase {
    NSString *libraryDirectoryURL;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    libraryDirectoryURL = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString: [libraryDirectoryURL stringByAppendingPathComponent:DataBaseName]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if (![filemgr fileExistsAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS ITEMS (ID INTEGER PRIMARY KEY, NAME TEXT, PRICE INTEGER, FORMATTED_PRICE TEXT, OFFER_PRICE INTEGER, OFFER_FORMATTED_PRICE TEXT, M_IMAGE TEXT, L_IMAGE TEXT);";
            
            if (sqlite3_exec(_database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                DDLogVerbose(@"Failed to create table");
            }
            sqlite3_close(_database);//////////
        }
        else {
            DDLogVerbose(@"Failed to open/create database");
        }
    }
}

- (NSMutableArray *)getFavorites:(BOOL)force_reload {
    
    if (!_database)
        return nil;
    
    if (!items || force_reload) {
        items = [[NSMutableArray alloc] init];
        NSString *query = @"select ID, NAME, PRICE, FORMATTED_PRICE, OFFER_PRICE, OFFER_FORMATTED_PRICE, M_IMAGE, L_IMAGE from ITEMS order by ID";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int idChars = (int) sqlite3_column_int(statement, 0);
                char *nameChars = (char *) sqlite3_column_text(statement, 1);
                int priceChars = (int) sqlite3_column_int(statement, 2);
                char *formattedPriceChars = (char *) sqlite3_column_text(statement, 3);
                int offerPriceChars = (int) sqlite3_column_int(statement, 4);
                char *offerFormattedPriceChars = (char *) sqlite3_column_text(statement, 5);
                char *mImageChars = (char *) sqlite3_column_text(statement, 6);
                char *lImageChars = (char *) sqlite3_column_text(statement, 7);
                
                Product *item = [[Product alloc] init];
                item.product_id = [NSString stringWithFormat:@"%d", idChars];
                item.product_label = [[NSString alloc] initWithUTF8String:nameChars];
                item.product_price = priceChars;
                item.product_offer_price = offerPriceChars;
                item.product_formatted_price = formattedPriceChars?[[NSString alloc] initWithUTF8String:formattedPriceChars]:@"";
                item.product_offer_formatted_price = offerFormattedPriceChars?[[NSString alloc] initWithUTF8String:offerFormattedPriceChars]:@"";
                [item.product_mimage addObject:[[NSString alloc] initWithUTF8String:mImageChars]];
                [item.product_limage addObject:[[NSString alloc] initWithUTF8String:lImageChars]];

                [items addObject:item];
            }
            sqlite3_finalize(statement);
        }
    }
    
    return items;
}

- (BOOL)insertItem:(Product *)product {
    NSString *base_query = @"INSERT INTO ITEMS(ID, NAME, PRICE, FORMATTED_PRICE, OFFER_PRICE, OFFER_FORMATTED_PRICE, M_IMAGE, L_IMAGE) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
    NSString *query = [[NSString alloc] initWithString:base_query];
    sqlite3_stmt *statement;
            
    if(sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [product.product_id UTF8String], -1, nil);
        sqlite3_bind_text(statement, 2, [product.product_label UTF8String], -1, nil);
        sqlite3_bind_int(statement, 3, (int)product.product_price);
        sqlite3_bind_text(statement, 4, [product.product_formatted_price UTF8String], -1, nil);
        sqlite3_bind_int(statement, 5, (int)product.product_offer_price);
        sqlite3_bind_text(statement, 6, [product.product_offer_formatted_price UTF8String], -1, nil);
        if (product.product_mimage.count>0)
            sqlite3_bind_text(statement, 7, [[product.product_mimage objectAtIndex:0] UTF8String], -1, nil);
        else
            sqlite3_bind_text(statement, 7, [@"" UTF8String], -1, nil);
        if (product.product_limage.count>0)
            sqlite3_bind_text(statement, 8, [[product.product_mimage objectAtIndex:0] UTF8String], -1, nil);
        else
            sqlite3_bind_text(statement, 8, [@"" UTF8String], -1, nil);
    }
    
    if (sqlite3_step(statement) == SQLITE_DONE) {
        sqlite3_finalize(statement);
        return YES;
    }
    
    return NO;
}

- (BOOL)deleteItem:(Product *)product {
    NSString *base_query = @"DELETE FROM ITEMS WHERE ID = ?";
    NSString *query = [[NSString alloc] initWithString:base_query];
    sqlite3_stmt *statement;
    
    if(sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [product.product_id UTF8String], -1, nil);
    }
    
    if (sqlite3_step(statement) == SQLITE_DONE) {
        sqlite3_finalize(statement);
        return YES;
    }
    
    return NO;
}

@end