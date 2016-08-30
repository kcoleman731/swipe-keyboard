//
//  STMultiSelectionBarBevelView.m
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTMultiSelectionBarBevelView.h"

@implementation BOTMultiSelectionBarBevelView

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Making a 'T' Bevel
    const CGFloat lineWidth = 1.0;
    UIBezierPath *bezPath = [UIBezierPath bezierPath];
    
    // Horiz
    [bezPath moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + (0.5f * lineWidth))];
    [bezPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + (0.5f * lineWidth))];
    
    // Vert
    [bezPath moveToPoint:CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect))];
    [bezPath addLineToPoint:CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))];
    
    [self.tintColor setStroke];
    [[UIColor clearColor] setFill];
    [bezPath setLineWidth:lineWidth];
    [bezPath stroke];
}

@end
