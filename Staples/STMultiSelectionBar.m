//
//  STMultiSelectionBar.m
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultiSelectionBar.h"
#import "STInvertedButton.h"
#import "STMultiSelectionBarBevelView.h"

@interface STMultiSelectionBar()

// Buttons
@property (nonatomic, strong) STInvertedButton *leftButton;
@property (nonatomic, strong) STInvertedButton *rightButton;

// Bevel
@property (nonatomic, strong) STMultiSelectionBarBevelView *bevel;

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
    [self.leftButton setTitleColor:self.leftButton.tintColor forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftButtonHit) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.leftButton];

    // Right Button
    self.rightButton = [[STInvertedButton alloc] init];
    [self.rightButton setTitleColor:self.rightButton.tintColor forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonHit) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.rightButton];
    
    [self addConstraintsForLeftButton];
    [self addConstraintsForRightButton];
}

- (void)constructBevel
{
    // Paint and close path
    self.bevel                        = [[STMultiSelectionBarBevelView alloc] initWithFrame:self.bounds];
    self.bevel.backgroundColor        = [UIColor clearColor];
    self.bevel.userInteractionEnabled = NO;
    self.bevel.autoresizingMask       = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.bevel];
}

#pragma mark - Tint Override

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.bevel.tintColor       = tintColor;
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
