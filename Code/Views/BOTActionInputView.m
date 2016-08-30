//
//  STActionInputView.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTActionInputView.h"
#import "BOTActionButton.h"

@interface BOTActionInputView ()

@property (nonatomic) NSArray *buttonItems;
@property (nonatomic) BOTActionButton *button1;
@property (nonatomic) BOTActionButton *button2;
@property (nonatomic) BOTActionButton *button3;

@property (nonatomic, strong) NSLayoutConstraint *btn1HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn2HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn3HeightConstraint;

@end

@implementation BOTActionInputView

NSUInteger const STPickerRowHeight = 52;
CGFloat const STBorderWidth = 1.0;
NSUInteger const STCornerRadius = 6;

- (id)initWithSelectionTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        
        UIColor *blue = [UIColor colorWithRed:118.0f/255.0f green:170.0f/255.0f blue:227.0f/255.0f alpha:1.0];
        self.layer.borderColor = blue.CGColor;
        self.layer.borderWidth = STBorderWidth;
        self.layer.cornerRadius = STCornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = blue;
        
        _button1 = [BOTActionButton initWithTitle:(NSString *)titles[0]];
        [_button1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button1];
        
        _button2 = [BOTActionButton initWithTitle:(NSString *)titles[1]];
        [_button2 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button2];
        
        _button3 = [BOTActionButton initWithTitle:(NSString *)titles[2]];
        [_button3 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button3];
        
        [self configureAutoLayoutConstraints];
    }
    return self;
}

- (void)buttonTapped:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(actionInputView:didSelectTitle:)]) {
        [self.delegate actionInputView:self didSelectTitle:sender.titleLabel.text];
    }
}

- (void)configureAutoLayoutConstraints
{
    // Button 1
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    self.btn1HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.3333f constant:0.0f];
    [self addConstraint:self.btn1HeightConstraint];
    
    // Button 2
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    self.btn2HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.3333f constant:0.0f];
    [self addConstraint:self.btn2HeightConstraint];
    
    // Button 3
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    self.btn3HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.3333f constant:0.0f];
    [self addConstraint:self.btn3HeightConstraint];
}

@end
