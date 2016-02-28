//
//  LoadingView.m
//  Kora Score
//
//  Created by Hasan S. Al-Bukhari on 12/18/14.
//  Copyright (c) 2014 Knockbook. All rights reserved.
//

#import "LoadingView.h"
#import "Singlton.h"

@implementation LoadingView

@synthesize delegate = _delegate;
@synthesize view;

@synthesize message;
@synthesize reloadButton;
@synthesize successImageView;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil];
        
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:view];
        
        [self.loadingBall stopAnimating];
        self.messageLabel.hidden = YES;
    }
    
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (self.view.superview != self)
        return;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0.0]];
    
//    [self sendSubviewToBack:view];
}

- (void)stopLoadingWithSuccess
{
    [self stopLoading];
    
    successImageView.hidden = NO;
    self.hidden = NO;
}

- (void)startLoadingWitMessage:(NSString *)message {
    [self animate];
    [self setMessageText:message];
    self.hidden = NO;
    self.loadingBall.userInteractionEnabled = NO;
    reloadButton.hidden = YES;
    successImageView.hidden = YES;
    animating = YES;
}

- (void)stopLoading {
    self.loadingBall.hidden = YES;
    self.loadingBall.userInteractionEnabled = NO;
    [self.loadingBall stopAnimating];
    [self setMessageText:nil];
    reloadButton.hidden = YES;
    
    successImageView.hidden = YES;
    self.hidden = YES;
    animating = NO;
}

- (void)stopLoadingWithMessage:(NSString *)message {
    self.loadingBall.hidden = YES;
    self.loadingBall.userInteractionEnabled = NO;
    [self.loadingBall stopAnimating];
    [self setMessageText:message];
    reloadButton.hidden = YES;
    self.hidden = NO;
    
    successImageView.hidden = YES;
    animating = NO;
}

- (void)stopLoadingWithError:(NSString *)message {
    self.loadingBall.hidden = NO;
    self.loadingBall.userInteractionEnabled = YES;
    [self.loadingBall stopAnimating];
    [self setMessageText:message];
    reloadButton.hidden = NO;
    self.hidden = NO;
    
    successImageView.hidden = YES;
    animating = NO;
}

- (void)setMessageText:(NSString *)text {
    if (text == nil || [text isEqualToString:@""]) {
        self.messageLabel.text = message = @"";
        self.messageLabel.hidden = YES;
    } else {
        self.messageLabel.text = message = [[[Singlton singlton] languageDetails] LocalString:text];
        self.messageLabel.hidden = NO;
    }
}

- (void)maintainAnimating
{
    if (animating)
    {
        [self animate];
    }
}

- (void)animate
{
//    [[[Singlton singlton] stylingDetails] runSpinAnimationOnView:self.loadingBall duration:1 rotations:1 repeat:connection_time_out direction:[[[Singlton singlton] languageDetails] rtl]];
    
    [self.loadingBall startAnimating];
}

- (IBAction)reloadGestureTriggered:(UITapGestureRecognizer *)sender {
    if (self.delegate)
        [self.delegate reload];
}

- (IBAction)reloadButtonTapped:(UIButton *)sender {
    if (self.delegate)
        [self.delegate reload];
}

@end
