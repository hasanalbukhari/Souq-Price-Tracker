//
//  StylingDetails.h
//  Yummy Wok
//
//  Created by Devloper on 3/12/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StylingDetails : NSObject

@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) UIColor *themeSecondaryColor;
@property (nonatomic, strong) UIColor *themeKaKiColor;
@property (nonatomic, strong) UIColor *themeBlueColor;
@property (nonatomic, strong) UIColor *themeGrayColor;

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat direction:(BOOL)direction;

@end
