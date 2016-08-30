//
//  STCellContainerView.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTCellContainerView.h"
#import "EDColor.h"

@implementation BOTCellContainerView

- (void)drawRect:(CGRect)rect
{
    /**
     *  Draw Triangle
     */
    const CGFloat rightTriangleLegWidth = 32.0;
    
    // Generate ctrl pts
    CGPoint firstPoint = CGPointMake(rect.origin.x + rect.size.width, 0.0);
    CGPoint secondPoint = CGPointMake(firstPoint.x - rightTriangleLegWidth, firstPoint.y);
    CGPoint thirdPoint = CGPointMake(firstPoint.x, firstPoint.y + rightTriangleLegWidth);
    
    // Gen path
    UIBezierPath *bezPath = [UIBezierPath bezierPath];
    [bezPath moveToPoint:firstPoint];
    [bezPath addLineToPoint:secondPoint];
    [bezPath addLineToPoint:thirdPoint];
    [bezPath closePath];
    
    // Set Color
    UIColor *lavaRed = [UIColor colorWithHexString:@"CE0B24"];
    [lavaRed setFill];
    
    // Fill
    [bezPath fill];
    
    /**
     *  Draw Text
     */
    
    // Attrs
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    
    UIColor *textColor = [UIColor whiteColor];
    NSDictionary *stringAttrs = @{NSFontAttributeName : font, NSForegroundColorAttributeName : textColor};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"i" attributes:stringAttrs];
    
    // Draw layout
    CGPoint textPoint = CGPointMake(rect.size.width - 12, rect.origin.y + 3);
    [attrStr drawAtPoint:textPoint];
}

@end
