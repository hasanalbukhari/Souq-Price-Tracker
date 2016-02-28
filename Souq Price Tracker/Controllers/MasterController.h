//
//  MasterController.h
//  Kader
//
//  Created by Devloper on 8/19/15.
//  Copyright © 2015 Devloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singlton.h"
#import "StylingDetails.h"
#import "UserDetails.h"
#import "LanguageDetails.h"

@interface MasterController : UIViewController

@property (nonatomic, weak) Singlton *singlton;
@property (nonatomic, weak) StylingDetails *stylingDetails;
@property (nonatomic, weak) UserDetails *userDetails;
@property (nonatomic, weak) LanguageDetails *languageDetails;

- (void) orientationChanged:(NSNotification *)notification;

@end
