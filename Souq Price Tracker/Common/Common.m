//
//  Common.m
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import "Common.h"
#import "Singlton.h"

#import <MessageUI/MessageUI.h>

@implementation Common

// get NSUserDefaults value for key
+ (id) valueForKey:(NSString *)key
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id val = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return val;
}

// get NSUserDefaults value for key and set default value if not exists
+ (id) valueForKey:(NSString *)key defaultValue:(id)default_value
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id val = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (val)
        return val;
    [Common setValue:default_value forKey:key];
    return default_value;
}

// set value for key in NSUserDefaults
+ (void) setValue:(id)value forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// should be remove I think!
+ (void)saveObject:(NSObject *)object key:(NSString *)key
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

// should be remove I think!
+ (NSObject *)loadObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

// validates email
+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (NSString *)getStringForArray:(NSMutableArray *)array {
    NSString *string = @"", *delimiter = @"";
    for (NSString *value in array) {
        string = [string stringByAppendingFormat:@"%@%@", delimiter, value];
        delimiter = @",";
    }
    return string;
}

+ (NSString *)stringEscaping:(NSString *)unescapedString {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)unescapedString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    return encodedString;
}

@end
