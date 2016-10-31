//
//  STActionButton.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTActionButton.h"
#import "BOTUtilities.h"

@interface BOTActionButton ()

@property NSUInteger verticalOffset;

@end

@implementation BOTActionButton

+ (instancetype)initWithTitle:(NSString *)title verticalOffset:(NSUInteger)offset
{
    return [[self alloc] initWithTitle:title veritcalOffset:offset];
}

- (id)initWithTitle:(NSString *)title veritcalOffset:(NSUInteger)offset
{
    self = [super init];
    if (self) {
        self.verticalOffset = offset;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:BOTBlueColor() forState:UIControlStateNormal];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSUInteger horizontalOffset = 2;
    NSUInteger verticalOffset = self.verticalOffset;
    NSUInteger curveOffset = (self.frame.size.height - (verticalOffset * 2)) / 2;
    
    NSUInteger left = horizontalOffset;
    NSUInteger right = self.frame.size.width - horizontalOffset;
    NSUInteger top = verticalOffset;
    NSUInteger bottom = self.frame.size.height - verticalOffset;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    UIColor *color = BOTBlueColor();
    [path moveToPoint:CGPointMake((left + curveOffset), top)];
    [path addLineToPoint:CGPointMake((right - curveOffset), top)];
    
    // Top Right Curve
    [path addQuadCurveToPoint:CGPointMake(right, top + curveOffset) controlPoint:CGPointMake(right, top)];
    [path addLineToPoint:CGPointMake(right, bottom - 4)];
    
    // Bottom Right Curve
    [path addQuadCurveToPoint:CGPointMake(right - 4, bottom) controlPoint:CGPointMake(right, bottom)];
    [path addLineToPoint:CGPointMake(left + curveOffset, bottom)];
    
    // Bottom Left Curve
    [path addQuadCurveToPoint:CGPointMake(left, bottom - curveOffset) controlPoint:CGPointMake(left, bottom)];
    [path addLineToPoint:CGPointMake(left, top + curveOffset)];
    
    // Top Left Curve
    [path addQuadCurveToPoint:CGPointMake((left + curveOffset), top) controlPoint:CGPointMake(left, top)];
    [path closePath];
    [color setStroke];

    path.lineWidth = 1;
    [path stroke];
}

@end
