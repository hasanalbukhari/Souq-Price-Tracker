//
//  StylingDetails.m
//  Yummy Wok
//
//  Created by Devloper on 3/12/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import "StylingDetails.h"

@implementation StylingDetails

@synthesize themeColor;
@synthesize themeSecondaryColor;
@synthesize themeKaKiColor;
@synthesize themeBlueColor;
@synthesize themeGrayColor;

- (id)init
{
    if (self = [super init]) {
        
        themeColor = [UIColor colorWithRed:38/255.0 green:41/255.0 blue:51/255.0 alpha:1.0f];
        themeSecondaryColor = [UIColor colorWithRed:12/255.0 green:93/255.0 blue:107/255.0 alpha:1.0f];
        themeKaKiColor = [UIColor colorWithRed:225/255.0 green:97/255.0 blue:16/255.0 alpha:1.0f];
        
        themeGrayColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0f];
        themeBlueColor = [UIColor colorWithRed:13/255.0 green:114/255.0 blue:254/255.0 alpha:1.0f];
        
        // To use custom fonts. Add the ttf or otf file to the app. and list it in the plist.
        // then, un-comment those lines to get font name to be used in code.
//        for (NSString* family in [UIFont familyNames])
//        {
//            DDLogVerbose(@"%@", family);
//            
//            for (NSString* name in [UIFont fontNamesForFamilyName: family])
//            {
//                DDLogVerbose(@"  %@", name);
//            }
//        }
    }
    return  self;
}

// spins a view. to use it as a custom loading icon!
- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat direction:(BOOL)direction
{
    if (direction)
        rotations *= -1;
    
    view.hidden = NO;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
