//
//  STMultiSelectionBar.m
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultiSelectionBar.h"
#import "STInvertedButton.h"

@interface STMultiSelectionBar()

// Buttons
@property (nonatomic, strong) STInvertedButton *leftButton;
@property (nonatomic, strong) STInvertedButton *rightButton;

// Bevel
@property (nonatomic, strong) CAShapeLayer *bevel;

@end

@implementation STMultiSelectionBar

#pragma mark - Init / CommonInit

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [self layoutButtons];
    [self constructBevel];
}

#pragma mark - Layout

- (void)layoutButtons
{
    // Left Button
    self.leftButton = [[STInvertedButton alloc] init];
    [self.leftButton setTitleColor:self.leftButton.tintColor forState:UIControlStateHighlighted];
    [self.leftButton addTarget:self action:@selector(leftButtonHit) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.leftButton];

    // Right Button
    self.rightButton = [[STInvertedButton alloc] init];
    [self.rightButton setTitleColor:self.rightButton.tintColor forState:UIControlStateHighlighted];
    [self.rightButton addTarget:self action:@selector(rightButtonHit) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.rightButton];
}

- (void)constructBevel
{
    // Making a 'T' Bevel
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithRect:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    
    // Horiz
    [bezPath moveToPoint:CGPointMake(0.0f, 0.0f)];
    [bezPath addLineToPoint:CGPointMake(100.0f, 0.0f)];
    [bezPath closePath];
    
    // Vert
    [bezPath moveToPoint:CGPointMake(50.0f, 0.0f)];
    [bezPath addLineToPoint:CGPointMake(50.0f, 100.0f)];
    [bezPath closePath];
    
    // Paint and close path
    self.bevel             = [[CAShapeLayer alloc] init];
    self.bevel.path        = [bezPath CGPath];
    self.bevel.lineWidth   = 1.0;
    self.bevel.strokeColor = self.tintColor.CGColor;
    [self.layer addSublayer:self.bevel];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutBevel];
}

- (void)layoutBevel
{
    self.bevel.frame = self.bounds;
}

#pragma mark - Tint Override

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.bevel.strokeColor     = [tintColor CGColor];
    self.leftButton.tintColor  = tintColor;
    self.rightButton.tintColor = tintColor;
    [self.leftButton setTitleColor:tintColor forState:UIControlStateHighlighted];
    [self.rightButton setTitleColor:tintColor forState:UIControlStateHighlighted];
}

#pragma mark - Button Title Setters

- (void)setLeftSelectionTitle:(NSString *)leftSelectionTitle
          rightSelectionTitle:(NSString *)rightSelectionTitle
{
    [self.leftButton setTitle:leftSelectionTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightSelectionTitle forState:UIControlStateNormal];
}

#pragma mark - Target / Action

- (void)leftButtonHit
{
    [self.delegate multiSelectionBar:self
           leftSelectionHitWithTitle:self.leftButton.titleLabel.text];
}

- (void)rightButtonHit
{
    [self.delegate multiSelectionBar:self
          rightSelectionHitWithTitle:self.rightButton.titleLabel.text];
}

#pragma mark - Constraints

- (void)addConstraintsForLeftButton
{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self addConstraints:@[leading, trailing, top, bottom]];
}

- (void)addConstraintsForRightButton
{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self addConstraints:@[leading, trailing, top, bottom]];
}

@end
