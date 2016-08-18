//
//  STActionInputView.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STActionInputView.h"
#import "STActionButton.h"

@interface STActionInputView ()

@property (nonatomic) NSArray *buttonItems;
@property (nonatomic) STActionButton *button1;
@property (nonatomic) STActionButton *button2;
@property (nonatomic) STActionButton *button3;
@property (nonatomic) STActionButton *button4;

@end

@implementation STActionInputView

NSUInteger const STPickerRowHeight = 52;
NSUInteger const STBorderWidth = 2;
NSUInteger const STCornerRadius = 6;

- (id)initWithSelectionItems:(NSArray *)selectionItems
{
    self = [super init];
    if (self) {
        
        UIColor *blue = [UIColor colorWithRed:118.0f/255.0f green:170.0f/255.0f blue:227.0f/255.0f alpha:1.0];
        self.layer.borderColor = blue.CGColor;
        self.layer.borderWidth = STBorderWidth;
        self.layer.cornerRadius = STCornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = blue;
        
        _button1 = [STActionButton initWithTitle:(NSString *)selectionItems[0]];
        [_button1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button1];
        
        _button2 = [STActionButton initWithTitle:(NSString *)selectionItems[1]];
        [_button2 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button2];
        
        _button3 = [STActionButton initWithTitle:(NSString *)selectionItems[2]];
        [_button3 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button3];
        
        _button4 = [STActionButton initWithTitle:(NSString *)selectionItems[3]];
        [_button4 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button4];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self configureAutoLayoutConstraints];
}

- (void)buttonTapped:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(actionInputView:didSelectItem:)]) {
        [self.delegate actionInputView:self didSelectItem:sender.titleLabel.text];
    }
}

- (void)configureAutoLayoutConstraints
{
    // Calculate row height.
    NSUInteger rowHeight = (self.frame.size.height - (3 * STBorderWidth)) / 4;
    
    // Button 1
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:rowHeight]];
    
    // Button 2
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:rowHeight]];
    
    // Button 3
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:rowHeight]];
    
    // Button 4
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button3 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:rowHeight]];
}

@end
