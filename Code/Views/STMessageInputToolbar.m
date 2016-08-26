//
//  STMessageInputToolbar.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMessageInputToolbar.h"
#import "STMultipleActionInputView.h"

extern NSString *const ATLMessageInputToolbarCameraButton;

// Kevin Coleman: Redeclaring these constants here, as they are private to the Atlas superclass.
// Note, these values are subject to change in the super.
static CGFloat const ATLLeftButtonHorizontalMargin = 6.0f;
static CGFloat const ATLLeftAccessoryButtonWidth = 40.0f;
static CGFloat const ATLRightAccessoryButtonDefaultWidth = 46.0f;
static CGFloat const ATLRightAccessoryButtonPadding = 5.3f;
static CGFloat const ATLRightButtonHorizontalMargin = 4.0f;
static CGFloat const ATLButtonHeight = 28.0f;

@interface ATLMessageInputToolbar ()

@property (nonatomic) CGFloat buttonCenterY;
@property (nonatomic) CGFloat textViewMaxHeight;
@property (nonatomic) UITextView *dummyTextView;
@property (nonatomic) BOOL firstAppearance;

- (void)configureRightAccessoryButtonState;

@end

@interface STMessageInputToolbar ()

@property (nonatomic) UIButton *listAccessoryButton;
@property (nonatomic) UIImage *listAccessoryButtonImage;
@property (nonnull, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation STMessageInputToolbar

- (id)init
{
    self = [super init];
    if (self) {
        NSBundle *resourcesBundle = ATLResourcesBundle();
        
        // Messages
        self.listAccessoryButtonImage = [UIImage imageNamed:@"location_dark" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
        self.listAccessoryButton = [[UIButton alloc] init];
        self.listAccessoryButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.listAccessoryButton setImage:self.listAccessoryButtonImage forState:UIControlStateNormal];
        [self.listAccessoryButton addTarget:self action:@selector(listButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        // Register for text change note
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(rightAccessoryButtonTappedEvent)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self.textInputView];
        // Adding target for right accessory btn
        [self.rightAccessoryButton addTarget:self
                                      action:@selector(rightAccessoryButtonTapped1)
                            forControlEvents:UIControlEventAllTouchEvents];
        
        [self addSubview:self.listAccessoryButton];
        [self setupLayoutConstraints];
        [self resizeTextViewAndFrame];
        
    }
    return self;
}

- (void)setupLayoutConstraints
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
    
    self.heightConstraint      = [NSLayoutConstraint constraintWithItem:self.textInputView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:40.0];
    
    [self addConstraints:@[leading, trailing, top, bottom, self.heightConstraint]];
}

- (void)layoutSubviews
{
    NSArray *layoutConstraints = self.constraints;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.constant == 44.0) {
            [self removeConstraint:constraint];
        }
    }
    
    // First apperance layout
    if (self.firstAppearance) {
        self.firstAppearance = NO;
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
    listButtonToRect.origin.y    = self.frame.size.height - vertPadding - listButtonToRect.size.height;

    // Left Button
    leftButtonToRect.size.height = ATLButtonHeight;
    leftButtonToRect.size.width  = ATLButtonHeight;
    leftButtonToRect.origin.x    = listButtonToRect.origin.x + listButtonToRect.size.width + ATLLeftButtonHorizontalMargin;
    leftButtonToRect.origin.y    = self.frame.size.height - vertPadding - listButtonToRect.size.height;
    
    // Right Button
    rightButtonToRect.size.height = ATLButtonHeight;
    rightButtonToRect.size.width  = ATLRightAccessoryButtonDefaultWidth;
    rightButtonToRect.origin.x    = CGRectGetMaxX(self.bounds) - ATLRightButtonHorizontalMargin - ATLRightAccessoryButtonDefaultWidth;
    rightButtonToRect.origin.y    = self.bounds.size.height - vertPadding - listButtonToRect.size.height;
    
    // Set All Frames
    self.listAccessoryButton.frame  = listButtonToRect;
    self.leftAccessoryButton.frame  = leftButtonToRect;
    self.rightAccessoryButton.frame = rightButtonToRect;
    
    // Getting the text input view frame here so we can bypass the call to super
    CGRect textViewRect = self.textInputView.frame;
    
    // Calc TextView Horiz Area
    CGFloat textViewToX     = CGRectGetMaxX(self.leftAccessoryButton.frame) + 16.0;
    CGFloat textViewToWidth = CGRectGetMinX(self.rightAccessoryButton.frame) - textViewToX;
    textViewRect.origin.x   = textViewToX;
    textViewRect.size.width = textViewToWidth;
    self.textInputView.frame = textViewRect;
}

- (void)resizeTextViewAndFrame
{
    // Getting the text input view frame here so we can bypass the call to super
    CGRect textViewRect = self.textInputView.frame;
    CGRect prevTextViewRect = textViewRect;

    // Calc TextView Vert Area
    CGSize toSize            = [self.textInputView sizeThatFits:CGSizeMake(textViewRect.size.width, MAXFLOAT)];
    CGFloat toHeight         = fmax(toSize.height, 30.0f);
    textViewRect.size.height = toHeight;
    
    // Set Text View Frame
    [self layoutIfNeeded];
    [UIView performWithoutAnimation:^{
        self.heightConstraint.constant = textViewRect.size.height;
    }];
    
    // Increase frame if need be
    CGRect toFrame      = self.frame;
    toFrame.size.height = toHeight + (2.0f * 8.0f);
    
    if (prevTextViewRect.size.height != toFrame.size.height) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ATLMessageInputToolbarDidChangeHeightNotification object:self];
    }
}

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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
