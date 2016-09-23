//
//  STMultiSelectionBar.m
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTMultiSelectionBar.h"
#import "BOTInvertedButton.h"
#import "BOTMultiSelectionBarBevelView.h"
#import "UIColor+Hex.h"
#import "BOTUtilities.h"

static NSString *const jordyBlueCode = @"#76AAE3";

@interface BOTMultiSelectionBar()

// Buttons
@property (nonatomic, strong) BOTInvertedButton *leftButton;
@property (nonatomic, strong) BOTInvertedButton *rightButton;

// Bevel
@property (nonatomic, strong) BOTMultiSelectionBarBevelView *bevel;

@end

@implementation BOTMultiSelectionBar

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
    self.backgroundColor = [UIColor whiteColor];
    [self layoutButtons];
    [self constructBevel];
    [self addConstraintsForBevel];
    
    // Color
    [self setTintColor:BOTBlueColor()];
}

#pragma mark - Layout

- (void)layoutButtons
{
    // Left Button
    self.leftButton = [[BOTInvertedButton alloc] init];
    [self.leftButton setTitleColor:self.leftButton.tintColor forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftButtonHit) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.leftButton];

    // Right Button
    self.rightButton = [[BOTInvertedButton alloc] init];
    [self.rightButton setTitleColor:self.rightButton.tintColor forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonHit) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.rightButton];
    
    [self addConstraintsForLeftButton];
    [self addConstraintsForRightButton];
}

- (void)constructBevel
{
    // Paint and close path
    self.bevel                        = [[BOTMultiSelectionBarBevelView alloc] initWithFrame:CGRectZero];
    self.bevel.backgroundColor        = [UIColor clearColor];
    self.bevel.userInteractionEnabled = NO;
    self.bevel.contentMode = UIViewContentModeRedraw;
    self.bevel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.bevel];
}

#pragma mark - Tint Override

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.bevel.tintColor       = tintColor;
    self.leftButton.tintColor  = tintColor;
    self.rightButton.tintColor = tintColor;
    [self.leftButton setTitleColor:tintColor forState:UIControlStateNormal];
    [self.rightButton setTitleColor:tintColor forState:UIControlStateNormal];
}

#pragma mark - Button Title Setters

- (void)setLeftSelectionTitle:(NSString *)leftSelectionTitle rightSelectionTitle:(NSString *)rightSelectionTitle
{
    [self.leftButton setTitle:leftSelectionTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightSelectionTitle forState:UIControlStateNormal];
}

#pragma mark - Target / Action

- (void)leftButtonHit
{
    [self.delegate multiSelectionBar:self leftSelectionHitWithTitle:self.leftButton.titleLabel.text];
    [self unhighlightButtons];
}

- (void)rightButtonHit
{
    [self.delegate multiSelectionBar:self rightSelectionHitWithTitle:self.rightButton.titleLabel.text];
    [self unhighlightButtons];
}

- (void)unhighlightButtons
{
    [self.leftButton setHighlighted:NO];
    [self.rightButton setHighlighted:NO];
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

- (void)addConstraintsForBevel
{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.bevel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.bevel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.bevel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.bevel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self addConstraints:@[leading, trailing, top, bottom]];
}

@end
