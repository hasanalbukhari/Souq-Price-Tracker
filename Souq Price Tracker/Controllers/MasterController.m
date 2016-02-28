//
//  MasterController.m
//  Kader
//
//  Created by Devloper on 8/19/15.
//  Copyright © 2015 Devloper. All rights reserved.
//

#import "MasterController.h"

@implementation MasterController

@synthesize singlton;
@synthesize stylingDetails;
@synthesize userDetails;
@synthesize languageDetails;

- (void)viewDidLoad {
    [super viewDidLoad];

    // initialise local references to be used in all subclasses
    singlton = [Singlton singlton];
    stylingDetails = [singlton stylingDetails];
    languageDetails = [singlton languageDetails];
    userDetails = [singlton userDetails];
    
    // status bar & navigation bar styling.
    if (self.tabBarController)
    {
        // navigation bar color
        self.tabBarController.tabBar.tintColor = [self.stylingDetails themeColor];
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.translucent = NO;
        
        if (self.tabBarController.navigationController)
            [self styleNavigationBar:self.tabBarController.navigationController];
        else
            [self setNeedsStatusBarAppearanceUpdate];
    }
    else
    {
        if (self.navigationController)
        {
            [self styleNavigationBar:self.navigationController];
        }
        else
        {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    
    if ([self respondsToSelector:@selector(orientationChanged:)]) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
}

- (void)styleNavigationBar:(UINavigationController *)navigationController {
    // navigation bar color
    navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    navigationController.navigationBar.barTintColor = [stylingDetails themeColor];
    navigationController.navigationBar.translucent = NO;
    
    // dark navigation bar style forces light status bar
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self.languageDetails LocalString:@"Back"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

// will be called in view controllers with no navigation controller.
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
