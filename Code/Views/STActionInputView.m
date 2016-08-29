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

@property (nonatomic, strong) NSLayoutConstraint *btn1HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn2HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn3HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn4HeightConstraint;

@end

@implementation STActionInputView

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
        
        _button1 = [STActionButton initWithTitle:(NSString *)titles[0]];
        [_button1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button1];
        
        _button2 = [STActionButton initWithTitle:(NSString *)titles[1]];
        [_button2 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button2];
        
        _button3 = [STActionButton initWithTitle:(NSString *)titles[2]];
        [_button3 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button3];
        
        _button4 = [STActionButton initWithTitle:(NSString *)titles[3]];
        [_button4 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button4];
        
        [self configureAutoLayoutConstraints];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustBtnHeight];
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
    self.btn1HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0f];
    [self addConstraint:self.btn1HeightConstraint];
    
    // Button 2
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    self.btn2HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0f];
    [self addConstraint:self.btn2HeightConstraint];
    
    // Button 3
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    self.btn3HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0f];
    [self addConstraint:self.btn3HeightConstraint];
    
    // Button 4
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button3 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
    self.btn4HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0f];
    [self addConstraint:self.btn4HeightConstraint];
    [self adjustBtnHeight];
}

- (void)adjustBtnHeight
{
    NSUInteger rowHeight = (self.bounds.size.height - (2.0 * STBorderWidth)) / 4.0;
    self.btn1HeightConstraint.constant = rowHeight;
    self.btn2HeightConstraint.constant = rowHeight;
    self.btn3HeightConstraint.constant = rowHeight;
    self.btn4HeightConstraint.constant = rowHeight;
    [self setNeedsLayout];
}

@end
