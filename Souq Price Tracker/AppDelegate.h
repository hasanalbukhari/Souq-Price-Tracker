//
//  AppDelegate.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/26/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singlton.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Singlton *singlton;

@end

