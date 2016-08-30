//
//  STMessageInputToolbar.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTMessageInputToolbar.h"
#import "BOTMultiSelectionBar.h"
#import "EDColor.h"

extern NSString *const ATLMessageInputToolbarCameraButton;

// Kevin Coleman: Redeclaring these constants here, as they are private to the Atlas superclass.
// Note, these values are subject to change in the super.
static CGFloat const ATLLeftButtonHorizontalMargin = 6.0f;
static CGFloat const ATLLeftAccessoryButtonWidth = 40.0f;
static CGFloat const ATLRightAccessoryButtonDefaultWidth = 46.0f;
static CGFloat const ATLRightAccessoryButtonPadding = 5.3f;
static CGFloat const ATLRightButtonHorizontalMargin = 4.0f;
static CGFloat const ATLButtonHeight = 28.0f;
static CGFloat const STMultiActionToolbarDefaultHeight = 48.0f;

NSString *const RightMultiActionInputViewButtonTapped = @"RightMultiActionInputViewButtonTapped";

@interface ATLMessageInputToolbar ()

@property (nonatomic) CGFloat buttonCenterY;
@property (nonatomic) CGFloat textViewMaxHeight;
@property (nonatomic) UITextView *dummyTextView;
@property (nonatomic) BOOL firstAppearance;

- (void)configureRightAccessoryButtonState;

@end

@interface BOTMessageInputToolbar () <BOTMultiSelectionBarDelegate, ATLMessageInputToolbarDelegate>

@property (nonatomic) UIButton *listAccessoryButton;
@property (nonatomic) UIImage *listAccessoryButtonImage;
@property (nonnull, strong) NSLayoutConstraint *inputTextViewHeightConstraint;
@property (nonnull, strong) NSLayoutConstraint *multiSelectionHeightConstraint;
@property (nonnull, strong) BOTMultiSelectionBar *multiActionInputView;;

@end

@implementation BOTMessageInputToolbar

- (id)init
{
    self = [super init];
    if (self) {
        // Register for text change note
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resizeTextViewAndFrame)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self.textInputView];
        
        // Adding target for right accessory btn
        [self.rightAccessoryButton addTarget:self
                                      action:@selector(rightAccessoryButtonTappedEvent)
                            forControlEvents:UIControlEventAllTouchEvents];
        
        // Accessorty Btn
        [self setupListAccessoryButton];
        
        // Multi Selection Bar
        [self setupMultiSelectionBar];
        [self setupMultiSelectionToolbarConstraints];
        
        // Init some layout
        [self setupTextInputViewConstraints];
        [self resizeTextViewAndFrame];
        
        // Custom images
        [self setCustomAccessoryButtonImages];
        
        // Turn off the auto suggestion bar
        self.textInputView.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (void)setupListAccessoryButton
{
    // Messages
    NSBundle *resourcesBundle = ATLResourcesBundle();
    self.listAccessoryButtonImage = [UIImage imageNamed:@"location_dark" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    self.listAccessoryButton = [[UIButton alloc] init];
    self.listAccessoryButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.listAccessoryButton setImage:self.listAccessoryButtonImage forState:UIControlStateNormal];
    [self.listAccessoryButton addTarget:self action:@selector(listButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.listAccessoryButton];
}

- (void)setupMultiSelectionBar
{
    self.multiActionInputView          = [[BOTMultiSelectionBar alloc] init];
    [self.multiActionInputView setLeftSelectionTitle:@"Continue shopping" rightSelectionTitle:@"Customize in cart"];
    self.multiActionInputView.delegate = self;
    self.multiActionInputView.alpha    = 0.0;
    self.multiActionInputView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.multiActionInputView];
}

- (void)displayMultiSelectionInputBar:(BOOL)displayBar;
{
    self.isShowingMultiSelectionBar = displayBar;
}

- (void)setIsShowingMultiSelectionBar:(BOOL)isShowingMultiSelectionBar
{
    if (_isShowingMultiSelectionBar != isShowingMultiSelectionBar) {
        _isShowingMultiSelectionBar = isShowingMultiSelectionBar;
        CGFloat toHeight = STMultiActionToolbarDefaultHeight;
        CGFloat toAlpha = 1.0f;
        if (!isShowingMultiSelectionBar) {
            toHeight = 0.0f;
            toAlpha = 0.0f;
        }
        
        // Animate to the position
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.multiSelectionHeightConstraint.constant = toHeight;
                             self.multiActionInputView.alpha = toAlpha;
                             [self layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             [[NSNotificationCenter defaultCenter] postNotificationName:ATLMessageInputToolbarDidChangeHeightNotification object:self];
                         }];
    }
}

#pragma mark - Override for Frame Calc

- (CGRect)frame
{
    if (self.isShowingMultiSelectionBar) {
        CGRect multiSelecitonFrame = self.multiActionInputView.frame;
        CGRect ownFrame            = [super frame];
        ownFrame.size.height       = ownFrame.size.height + multiSelecitonFrame.size.height;
        ownFrame.origin.y          = multiSelecitonFrame.origin.y;
        return ownFrame;
    }
    return [super frame];
}

#pragma mark - Target / Action Reveivers

- (void)rightAccessoryButtonTappedEvent
{
    [self resizeTextViewAndFrame];
}

- (void)listButtonTapped:(UIButton *)sender
{
    if ([self.customDelegate respondsToSelector:@selector(messageInputToolbar:didTapListAccessoryButton:)]) {
        [self.customDelegate messageInputToolbar:self didTapListAccessoryButton:sender];
    }
}

#pragma mark - Accessory Button Images

- (void)setCustomAccessoryButtonImages
{
    UIImage *cameraGlyph = [UIImage imageNamed:@"camera_glyph"];
    UIImage *listGlyph   = [UIImage imageNamed:@"list_glyph"];
    
    UIImage *cameraGlyphSelected = [UIImage imageNamed:@"camera_glyph_selected"];
    UIImage *listGlyphSelected   = [UIImage imageNamed:@"list_glyph_selected"];
    
    self.listAccessoryButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.leftAccessoryButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // Normal
    [self.listAccessoryButton setImage:listGlyph forState:UIControlStateNormal];
    [self.leftAccessoryButton setImage:cameraGlyph forState:UIControlStateNormal];
    
    // Highlighted
    [self.listAccessoryButton setImage:listGlyphSelected forState:UIControlStateHighlighted];
    [self.leftAccessoryButton setImage:cameraGlyphSelected forState:UIControlStateHighlighted];
    
    // Shink the list and cam a bit
    [self.listAccessoryButton setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0)];
    [self.leftAccessoryButton setContentEdgeInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
}

#pragma mark - Subview Layouts

- (void)layoutSubviews
{
    // Disable if no text
    self.rightAccessoryButton.enabled = self.textInputView.text.length;

    // Remove the layout constraint for height attempting to lock this at 44.0
    NSArray *layoutConstraints = self.constraints;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.constant == 44.0) {
            [self removeConstraint:constraint];
        }
    }
    
    // First apperance layout. Look for absent text on send button
    if (!self.rightAccessoryButton.titleLabel.text) {
        [self configureRightAccessoryButtonState];
    }
    
    CGRect listButtonToRect;
    CGRect leftButtonToRect;
    CGRect rightButtonToRect;
    
    // Configure leading edge buttons
    // Note: Horiz Order -> [ListButton] [LeftButton] [TextView] [RightButton]
    
    // Const Bottom Padding
    const CGFloat vertPadding = 8.0f;
    
    // List Button
    listButtonToRect.size.height = ATLButtonHeight;
    listButtonToRect.size.width  = ATLButtonHeight;
    listButtonToRect.origin.x    = ATLLeftButtonHorizontalMargin;
    listButtonToRect.origin.y    = self.bounds.size.height - vertPadding - listButtonToRect.size.height;

    // Left Button
    leftButtonToRect.size.height = ATLButtonHeight;
    leftButtonToRect.size.width  = ATLButtonHeight;
    leftButtonToRect.origin.x    = listButtonToRect.origin.x + listButtonToRect.size.width + ATLLeftButtonHorizontalMargin;
    leftButtonToRect.origin.y    = self.bounds.size.height - vertPadding - listButtonToRect.size.height;
    
    // Right Button
    rightButtonToRect.size.height = ATLButtonHeight;
    rightButtonToRect.size.width  = ATLRightAccessoryButtonDefaultWidth;
    rightButtonToRect.origin.x    = CGRectGetMaxX(self.bounds) - ATLRightButtonHorizontalMargin - ATLRightAccessoryButtonDefaultWidth;
    rightButtonToRect.origin.y    = self.bounds.size.height - vertPadding - listButtonToRect.size.height - 2.0;
    
    // Set All Frames
    self.listAccessoryButton.frame  = listButtonToRect;
    self.leftAccessoryButton.frame  = leftButtonToRect;
    self.rightAccessoryButton.frame = rightButtonToRect;
    
    // Getting the text input view frame here so we can bypass the call to super
    CGRect textViewRect = self.textInputView.frame;
    
    // Calc TextView Horiz Area
    CGFloat textViewToX      = CGRectGetMaxX(self.leftAccessoryButton.frame) + 16.0;
    CGFloat textViewToWidth  = CGRectGetMinX(self.rightAccessoryButton.frame) - textViewToX;
    textViewRect.origin.x    = textViewToX;
    textViewRect.size.width  = textViewToWidth;
    self.textInputView.frame = textViewRect;
}

- (void)resizeTextViewAndFrame
{
    // Getting the text input view frame here so we can bypass the call to super
    CGRect textViewRect = self.textInputView.frame;
    CGRect prevTextViewRect = textViewRect;

    // Calc TextView Vert Area
    [self.textInputView sizeToFit];
    [self.textInputView layoutIfNeeded];
    CGSize toSize            = [self.textInputView sizeThatFits:CGSizeMake(textViewRect.size.width, MAXFLOAT)];
    CGFloat toHeight         = fmax(toSize.height, 30.0f);
    textViewRect.size.height = toHeight;
    
    // Set Text View Frame
    [self layoutIfNeeded];
    [UIView performWithoutAnimation:^{
        self.inputTextViewHeightConstraint.constant = textViewRect.size.height;
    }];
    
    // Increase frame if need be
    CGRect toFrame      = self.frame;
    toFrame.size.height = toHeight + (2.0f * 8.0f);
    
    // Notify of height change
    if (prevTextViewRect.size.height != toFrame.size.height) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ATLMessageInputToolbarDidChangeHeightNotification object:self];
    }
}

#pragma mark - Touch Overrides For UI Interaction w/ View Outside of frame

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // Look for taps in the text view
    if (CGRectContainsPoint(self.textInputView.frame, point) && self.textInputView.inputView) {
        self.textInputView.inputView = nil;
        [self.textInputView reloadInputViews];
        [self.textInputView becomeFirstResponder];
    }

    // Return YES if the touch is within bounds or multiaction view
    if (CGRectContainsPoint(self.bounds, point) || CGRectContainsPoint(self.multiActionInputView.frame, point)) {
        return YES;
    }
    
    return NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint pointForTargetView = [self.multiActionInputView convertPoint:point fromView:self];
    
    if (CGRectContainsPoint(self.multiActionInputView.bounds, pointForTargetView)) {
        return [self.multiActionInputView hitTest:pointForTargetView withEvent:event];
    }
    
    return [super hitTest:point withEvent:event];
}

#pragma mark - Layout Constraints

- (void)setupMultiSelectionToolbarConstraints
{
    [self.multiActionInputView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *leading  = [NSLayoutConstraint constraintWithItem:self.multiActionInputView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.multiActionInputView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:0.0];
    
    NSLayoutConstraint *bottom   = [NSLayoutConstraint constraintWithItem:self.multiActionInputView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:0.0];
    
    self.multiSelectionHeightConstraint = [NSLayoutConstraint constraintWithItem:self.multiActionInputView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:0.0f];
    
    [self addConstraints:@[leading, trailing, bottom, self.multiSelectionHeightConstraint]];
}

- (void)setupTextInputViewConstraints
{
    [self.textInputView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *leading  = [NSLayoutConstraint constraintWithItem:self.textInputView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.leftAccessoryButton
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:8.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.textInputView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.rightAccessoryButton
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:-8.0];
    
    NSLayoutConstraint *bottom   = [NSLayoutConstraint constraintWithItem:self.textInputView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:-8.0];
    
    NSLayoutConstraint *top      = [NSLayoutConstraint constraintWithItem:self.textInputView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:8.0];
    
    self.inputTextViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.textInputView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:40.0];
    
    [self addConstraints:@[leading, trailing, top, bottom, self.inputTextViewHeightConstraint]];
}

#pragma mark - ATLMessageInputToolbarDelegate

- (void)messageInputToolbarDidType:(ATLMessageInputToolbar *)messageInputToolbar
{
    [self resizeTextViewAndFrame];
}

#pragma mark - STMultiSelectionBarDelegate Calls

- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar leftSelectionHitWithTitle:(NSString *)title
{
    [self.customDelegate messageInputToolbar:self multiSelectionBarTappedWithTitle:title];
}

- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar rightSelectionHitWithTitle:(NSString *)title
{
    [self.customDelegate messageInputToolbar:self multiSelectionBarTappedWithTitle:title];
}

#pragma mark - Gesture Recognizers

- (void)tapDetectedOnTextInput
{
    self.textInputView.inputView = nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
