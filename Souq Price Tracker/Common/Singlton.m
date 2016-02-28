//
//  Singlton.m
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import "Singlton.h"
#import "Common.h"

@implementation Singlton

@synthesize userDetails;
@synthesize stylingDetails;
@synthesize fileLogging;
@synthesize apiHelper;
@synthesize languageDetails;

// this object can't be initialised more than once.
+ (id)singlton
{
    static Singlton *single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DDLogVerbose(@"Singlton object initialized for the first time.");
        single = [[self alloc] init];
    });
    
    return single;
}

- (id)init
{
    if (self = [super init]) {
        userDetails = [[UserDetails alloc] init];
        stylingDetails = [[StylingDetails alloc] init];
        fileLogging = [[FileLogging alloc] init];
        apiHelper = [[APIHelper alloc] init];
        languageDetails = [[LanguageDetails alloc] init];
    }
    return  self;
}

@end
