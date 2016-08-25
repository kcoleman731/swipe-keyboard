//
//  BOTActionCollectionViewCell.m
//  
//
//  Created by Kevin Coleman on 8/25/16.
//
//

#import "BOTActionCollectionViewCell.h"

NSString *const BOTActionMIMEType = @"BOTActionMIMEType";
NSString *const BOTActionCollectionViewCellButtonTapped = @"BOTActionCollectionViewCellButtonTapped";
NSString *const BOTActionCollectionViewCellReuseIdentifier = @"BOTActionCollectionViewCellReuseIdentifier";

@interface ATLBaseCollectionViewCell ()

@property (nonatomic) NSLayoutConstraint *bubbleWithAvatarLeadConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithoutAvatarLeadConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleViewWidthConstraint;

@end

@interface ATLIncomingMessageCollectionViewCell ();

- (void)configureLayoutConstraints;
- (void)lyr_incommingCommonInit;

@end

@interface BOTActionCollectionViewCell ()

@property (nonatomic) UIButton *actionButton;

@end

@implementation BOTActionCollectionViewCell


- (void)lyr_incommingCommonInit
{
    [super lyr_incommingCommonInit];
    
    self.actionButton = [UIButton new];
    [self.actionButton setTitle:@"View My Cart" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.actionButton addTarget:self action:@selector(actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.actionButton.layer.cornerRadius = 4;
    self.actionButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.actionButton.layer.borderWidth = 1;
    [self.contentView addSubview:self.actionButton];
    [self configureActionButtonConstraints];
}

- (void)configureLayoutConstraints
{
    self.bubbleWithAvatarLeadConstraint = [NSLayoutConstraint new];
    self.bubbleWithoutAvatarLeadConstraint = [NSLayoutConstraint new];
    
    CGFloat maxBubbleWidth = ATLMaxCellWidth() + ATLMessageBubbleLabelHorizontalPadding * 2;
    self.bubbleViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:maxBubbleWidth];
    [self.contentView addConstraint:self.bubbleViewWidthConstraint];
    // Constrain Bubble Height Here.
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-40]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}

- (void)configureActionButtonConstraints
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
}

- (void)actionButtonTapped:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOTActionCollectionViewCellButtonTapped object:self];
}

@end
