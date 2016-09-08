//
//  BOTOrderStatusViewCellBottomBorderView.m
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderStatusViewCellBottomBorderView.h"

@implementation BOTOrderStatusViewCellBottomBorderView

- (void)drawRect:(CGRect)rect {
    // Width
    const CGFloat borderThickness = 0.5f;
    
    // Draw
    UIBezierPath *topBorder = [UIBezierPath bezierPath];
    [topBorder moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + borderThickness)];
    [topBorder addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + borderThickness)];
    
    // Ctx
    [[[UIColor grayColor] colorWithAlphaComponent:0.3f] setStroke];
    [topBorder setLineWidth:borderThickness];
    
    // Draw!
    [topBorder stroke];
}

@end
