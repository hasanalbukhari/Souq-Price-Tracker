//
//  LanguageDetails.h
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageDetails : NSObject

- (BOOL)rtl;
- (void)changeLanguage;
- (void)changeLanguageTo:(NSString *)lang;
- (NSString *) LocalString:(NSString *)key;
- (NSLocale *)getLocale;

@property (nonatomic, strong) NSString *language;

@end
