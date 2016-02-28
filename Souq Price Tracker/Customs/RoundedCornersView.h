//
//  RoundedCornersView.h
//  Kader
//
//  Created by Devloper on 8/20/15.
//  Copyright © 2015 Devloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundedCornersView : UIView
{
    CGSize cornorRadius;
    CGFloat borderWidth;
    UIColor *borderColor;
}

@property (nonatomic, strong) UIColor *color;

- (void)setCornerRadius:(CGSize)radius;
- (void)setBorderWidth:(CGFloat)width;
- (void)setBorderColor:(UIColor *)border_color;

@end
