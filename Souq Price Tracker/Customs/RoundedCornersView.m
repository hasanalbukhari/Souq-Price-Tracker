//
//  RoundedCornersView.m
//  Kader
//
//  Created by Devloper on 8/20/15.
//  Copyright © 2015 Devloper. All rights reserved.
//

#import "RoundedCornersView.h"
#import "Singlton.h"

@implementation RoundedCornersView

@synthesize color;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        color = [self backgroundColor];
        [self setBackgroundColor:[UIColor clearColor]];
        cornorRadius = CGSizeMake(4, 4);
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
    color = backgroundColor;
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

- (void)setCornerRadius:(CGSize)radius
{
    cornorRadius = radius;
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

- (void)setBorderWidth:(CGFloat)width
{
    borderWidth = width;
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

- (void)setBorderColor:(UIColor *)border_color
{
    borderColor = border_color;
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

// redraw without increasing or decreasing hiting area.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    // drawing context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set fill color
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    // set stroke color
    CGContextSetStrokeColor(context, CGColorGetComponents(borderColor.CGColor));
    
    // corners to round
    UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft |UIRectCornerTopRight;
    
    // bezier path rect
    CGRect bezierRect = CGRectMake(rect.origin.x+borderWidth*0.5, rect.origin.y+borderWidth*0.5, rect.size.width-borderWidth, rect.size.height-borderWidth);
    
    // rounded path
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:bezierRect byRoundingCorners:corners cornerRadii:cornorRadius];
    
    // set stroke width
    [roundedPath setLineWidth:borderWidth];
    
    // fill coloring
    [roundedPath fill];
    
    // stroke coloring
    [roundedPath stroke];
}

@end
