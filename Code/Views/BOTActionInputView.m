//
//  STActionInputView.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTActionInputView.h"
#import "BOTActionButton.h"
#import "BOTUtilities.h"

@interface BOTActionInputView ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *actions;
@property (nonatomic) NSArray *buttonItems;
@property (nonatomic) BOTActionButton *button1;
@property (nonatomic) BOTActionButton *button2;
@property (nonatomic) BOTActionButton *button3;
@property (nonatomic) BOTActionButton *button4;

@property (nonatomic, strong) NSLayoutConstraint *btn1HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn2HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn3HeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *btn4HeightConstraint;

@end

@implementation BOTActionInputView

NSUInteger const STPickerRowHeight = 52;
CGFloat const STBorderWidth = 1.0;
NSUInteger const STCornerRadius = 6;
NSUInteger const STButtonOffset = 8;

- (id)initWithSelectionTitles:(NSArray *)titles actions:(NSArray *)actions
{
    self = [super init];
    if (self) {
        self.titles = titles;
        self.actions = actions;
        
        if (titles.count > 0) {
            _button1 = [BOTActionButton initWithTitle:(NSString *)titles[0] verticalOffset:STButtonOffset];
            [_button1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            _button1.tag = 0;
            [self addSubview:_button1];
        }
        
        if (titles.count > 1) {
            _button2 = [BOTActionButton initWithTitle:(NSString *)titles[1] verticalOffset:STButtonOffset];
            [_button2 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            _button1.tag = 1;
            [self addSubview:_button2];
        }
        
        if (titles.count > 2) {
            _button3 = [BOTActionButton initWithTitle:(NSString *)titles[2] verticalOffset:STButtonOffset];
            [_button3 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            _button3.tag = 2;
            [self addSubview:_button3];
        }

        
        [self configureAutoLayoutConstraints];
    }
    return self;
}

- (void)buttonTapped:(UIButton *)sender
{
    NSString *actionTitle = @"";
    if (self.actions.count > sender.tag) {
       actionTitle = [self.actions objectAtIndex:sender.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(actionInputView:didSelectTitle:actions:)]) {
        [self.delegate actionInputView:self didSelectTitle:sender.titleLabel.text actions:actionTitle] ;
    }
}

- (void)configureAutoLayoutConstraints
{
    // Button 1
    if (self.titles.count > 0) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        self.btn1HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:0.0f];
        [self addConstraint:self.btn1HeightConstraint];
    }
    
    // Button 2
    if (self.titles.count > 1) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
        self.btn2HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:0.0f];
        [self addConstraint:self.btn2HeightConstraint];
    }
    
    // Button 3
    if (self.titles.count > 2) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:STBorderWidth]];
        self.btn3HeightConstraint = [NSLayoutConstraint constraintWithItem:self.button3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:0.0f];
        [self addConstraint:self.btn3HeightConstraint];
    }
}

- (void)layoutSubviews
{
    CGFloat height = self.frame.size.height / 3;
    self.btn1HeightConstraint.constant = height;
    self.btn2HeightConstraint.constant = height;
    self.btn3HeightConstraint.constant = height;
}

@end
