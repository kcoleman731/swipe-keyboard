//
//  BOTCollectionViewFooterCell.m
//  Staples
//
//  Created by Kevin Coleman on 10/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTCollectionViewFooterCell.h"
#import "BOTActionButton.h"

NSString *const BOTCollectionViewFooterCellReuseIdentifier = @"BOTCollectionViewFooterCellReuseIdentifier";

@interface BOTCollectionViewFooterCell ();

@property (nonatomic) BOTActionButton *button;

@end

@implementation BOTCollectionViewFooterCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.button = [BOTActionButton initWithTitle:@"test" verticalOffset:4];
        [self.contentView addSubview:self.button];
        [self configureButtonConstraints];
    }
    return self;
}

- (void)updateWithTitle:(NSString *)title
{
    [self.button setTitle:title forState:UIControlStateNormal];
}

+ (NSString *)reuseIdentifier
{
    return BOTCollectionViewFooterCellReuseIdentifier;
}

- (void)configureButtonConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.95 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
}

@end
