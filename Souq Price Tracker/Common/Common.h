//
//  Common.h
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HttpHandler.h"
#import "UserDetails.h"

@interface Common : NSObject

+ (id) valueForKey:(NSString *)key;
+ (id) valueForKey:(NSString *)key defaultValue:(id)default_value;
+ (void) setValue:(id)value forKey:(NSString *)key;
+ (void)saveObject:(NSObject *)object key:(NSString *)key;
+ (NSObject *)loadObjectWithKey:(NSString *)key;
+ (BOOL) validateEmail: (NSString *) candidate;
+ (NSString *)getStringForArray:(NSMutableArray *)array;
+ (NSString *)stringEscaping:(NSString *)unescapedString;

@end
