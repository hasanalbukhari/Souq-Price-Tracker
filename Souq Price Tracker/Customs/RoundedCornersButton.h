//
//  RoundedCornersButton.h
//  Kader
//
//  Created by Devloper on 8/20/15.
//  Copyright © 2015 Devloper. All rights reserved.
//
// RoundedCornersButton Custom Class drawing rectangle does not get affected by the contentEdgeInsets value. can be observed in - (void)drawRect:(CGRect)rect

#import <UIKit/UIKit.h>

@interface RoundedCornersButton : UIButton
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
