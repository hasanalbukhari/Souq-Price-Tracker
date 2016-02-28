//
//  LoginViewController.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/26/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "MasterController.h"
#import "RoundedCornersButton.h"
#import "LoadingView.h"
#import "APIHelper.h"

@interface LoginViewController : MasterController <APIAuthorizationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *splashIconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *splashIconHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *splashIconVerticalConstraint;

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (weak, nonatomic) IBOutlet RoundedCornersButton *loginButton;
@property (weak, nonatomic) IBOutlet RoundedCornersButton *skipButton;

@property (strong, nonatomic) NSURL *authURL;

@end
