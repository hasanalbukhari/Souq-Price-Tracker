//
//  LoginViewController.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/26/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize splashIconImageView;
@synthesize splashIconHeightConstraint;
@synthesize splashIconVerticalConstraint;
@synthesize authURL;
@synthesize loadingView;
@synthesize loginView;
@synthesize loginButton;
@synthesize skipButton;

- (IBAction)sendLogFileByMail:(RoundedCornersButton *)sender {
    [[[Singlton singlton] fileLogging] composeEmailWithDebugAttachment:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLocalizedText];
    [self styleLoadingView];
    
    // prepare to be shown with animation
    [loginView setAlpha:0.0];
    if (![[self.userDetails code] isEqualToString:@""]) {
        [loginView setHidden:YES];
    }
}

- (void)setLocalizedText {
    [loginButton setTitle:[self.languageDetails LocalString:@"Login"] forState:UIControlStateNormal];
    [skipButton setTitle:[self.languageDetails LocalString:@"Skip"] forState:UIControlStateNormal];
}

- (void)styleLoadingView {
    [loadingView.messageLabel setTextColor:[UIColor whiteColor]];
    [loadingView.loadingBall setColor:[UIColor whiteColor]];
    [loadingView.reloadButton setTintColor:[UIColor whiteColor]];
    [loadingView.reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[self.userDetails code] isEqualToString:@""])
        [self animateSplashIcon];
    else
        [self performSegueWithIdentifier:@"ProductTypesSegue" sender:self];
}

- (void)animateSplashIcon {
    // setup for animation.
    [self.view layoutIfNeeded];
    
    // set animation values.
    splashIconHeightConstraint.constant = 120;
    splashIconVerticalConstraint.constant = - self.view.frame.size.height * 0.3;
    
    // animate.
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
        [loginView setAlpha:1.0];
    }];
}

- (void)requestAuthorizationPage {
    authURL = [NSURL URLWithString:[[self.singlton apiHelper] authorizationURL]];
    
    [[self.singlton apiHelper] setDelegate:self];
    [[UIApplication sharedApplication] openURL:authURL];
    
    [loadingView startLoadingWitMessage:@"Waiting"];
    [loginButton setTitle:[self.languageDetails LocalString:@"Cancel"] forState:UIControlStateNormal];
}

- (IBAction)loginButtonTapped:(RoundedCornersButton *)sender {
    if ([[[loginButton titleLabel] text] isEqualToString:[self.languageDetails LocalString:@"Cancel"]]) {
        [self cancelLoging];
    } else {
        [self requestAuthorizationPage];
    }
}

- (IBAction)skipButtonTapped:(RoundedCornersButton *)sender {
    [self cancelLoging];
    [self performSegueWithIdentifier:@"ProductTypesSegue" sender:self];
}

- (void)cancelLoging {
    [loginButton setTitle:[self.languageDetails LocalString:@"Login"] forState:UIControlStateNormal];
    [[self.singlton apiHelper] setDelegate:nil];
    [loadingView stopLoading];
}

- (void)userAuthorized:(NSString *)code {
    [self.userDetails setCode:code];
    if (![[self.userDetails code] isEqualToString:@""]) {
        [loadingView stopLoadingWithSuccess];
        [loginView setHidden:YES];
        [splashIconImageView setHidden:YES];
        [self performSegueWithIdentifier:@"ProductTypesSegue" sender:self];
    } else {
        [loadingView stopLoadingWithMessage:@"Fail"];
        [loginButton setTitle:[self.languageDetails LocalString:@"Login"] forState:UIControlStateNormal];
    }
}

- (void) orientationChanged:(NSNotification *)notification
{
    UIDevice * device = notification.object;
    [self.view layoutIfNeeded];
}

@end
