//
//  Singlton.h
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetails.h"
#import "StylingDetails.h"
#import "FileLogging.h"
#import "APIHelper.h"
#import "LanguageDetails.h"


@interface Singlton : NSObject

+ (id)singlton;

@property (nonatomic, strong) UserDetails *userDetails;
@property (nonatomic, strong) StylingDetails *stylingDetails;
@property (nonatomic, strong) FileLogging *fileLogging;
@property (nonatomic, strong) APIHelper *apiHelper;
@property (nonatomic, strong) LanguageDetails *languageDetails;

@end
