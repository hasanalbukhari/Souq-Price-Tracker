//
//  LanguageDetails.m
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import "LanguageDetails.h"
#import "Common.h"

#import "Singlton.h"

@implementation LanguageDetails

@synthesize language;

#define LANGUAGE_KEY @"LANGUAGE_KEY"

- (id)init
{
    if (self = [super init]) {
        
        // user preferred languages. this the default app. language. first launch app. language!
//        language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
        language = @"en";
        
//        if (![language isEqualToString:@"ar"])
//            language = @"Base";
        
        // save language to NSUserDefaults
        language = [Common valueForKey:LANGUAGE_KEY defaultValue:language];
    }
    return  self;
}

// returns app. language direction.
- (BOOL)rtl {
    return [NSLocale characterDirectionForLanguage:language] == NSLocaleLanguageDirectionRightToLeft;
}

// switches language.
- (void)changeLanguage
{
    // check current language to switch to the other.
    if ([language isEqualToString:@"ar"])
        language = @"en";
    else
        language = @"ar";
    
    // save language to NSUserDefaults
    [Common setValue:language forKey:LANGUAGE_KEY];
    
    DDLogVerbose(@"Language changed to: %@", language);
}

// change language to a specfic one.
- (void)changeLanguageTo:(NSString *)lang
{
    language = lang;
    
    // save language to NSUserDefaults
    [Common setValue:language forKey:LANGUAGE_KEY];
    
    DDLogVerbose(@"Language changed to: %@", language);
}

- (NSLocale *)getLocale {
    if ([self rtl])
        return [[NSLocale alloc] initWithLocaleIdentifier:@"ar_JO"];
    else
        return [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
}

// get localized string based on app. langauge.
- (NSString *) LocalString:(NSString *)key {
    NSString *localizedString = NSLocalizedStringFromTableInBundle(key, [language isEqualToString:@"en"]?@"Base":language, [NSBundle mainBundle], nil);
    DDLogVerbose(@"Localized string '%@' for key '%@'", localizedString, key);
    return localizedString;
}

@end
