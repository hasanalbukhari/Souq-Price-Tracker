//
//  LoadingView.h
//  Kora Score
//
//  Created by Hasan S. Al-Bukhari on 12/18/14.
//  Copyright (c) 2014 Knockbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadingDelegate <NSObject>

@required
- (void)reload;
@end

@interface LoadingView : UIView
{
    __weak id <LoadingDelegate> _delegate;
    BOOL animating;
}

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingBall;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *reloadTapGesture;
@property (weak, nonatomic) IBOutlet UIImageView *successImageView;
@property (nonatomic, weak) id <LoadingDelegate> delegate;
@property (strong, nonatomic) NSString *message;

- (void)stopLoading;
- (void)stopLoadingWithSuccess;
- (void)stopLoadingWithError:(NSString *)message;
- (void)stopLoadingWithMessage:(NSString *)message;
- (void)startLoadingWitMessage:(NSString *)message;
- (void)maintainAnimating;

@end
