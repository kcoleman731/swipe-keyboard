//
//  BOTOrderStatusViewCellTopBorderView.m
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTOrderStatusViewCellTopBorderView.h"

@implementation BOTOrderStatusViewCellTopBorderView

- (void)drawRect:(CGRect)rect {
    
    // Width
    const CGFloat borderThickness = 0.5f;
    
    // Draw
    UIBezierPath *bottomBorder = [UIBezierPath bezierPath];
    [bottomBorder moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - borderThickness)];
    [bottomBorder addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - borderThickness)];
    
    // Ctx
    [[[UIColor grayColor] colorWithAlphaComponent:0.3f] setStroke];
    
    // Draw!
    [bottomBorder stroke];
}

@end
