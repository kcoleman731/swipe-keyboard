//
//  STMessageInputToolbar.m
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMessageInputToolbar.h"

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

@end

@implementation STMessageInputToolbar

- (id)init
{
    self = [super init];
    if (self) {
        NSBundle *resourcesBundle = ATLResourcesBundle();
        self.listAccessoryButtonImage = [UIImage imageNamed:@"location_dark" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
        
        self.listAccessoryButton = [[UIButton alloc] init];
        self.listAccessoryButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.listAccessoryButton setImage:self.listAccessoryButtonImage forState:UIControlStateNormal];
        [self.listAccessoryButton addTarget:self action:@selector(listButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.listAccessoryButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.firstAppearance) {
        [self configureRightAccessoryButtonState];
        self.firstAppearance = NO;
    }
    
    // set the font for the dummy text view as well
    self.dummyTextView.font = self.textInputView.font;
    
    // We layout the views manually since using Auto Layout seems to cause issues in this context (i.e. an auto height resizing text view in an input accessory view) especially with iOS 7.1.
    CGRect frame = self.frame;
    
    // Kevin Coleman: Including the list button frame.
    CGRect listButtonFrame = self.listAccessoryButton.frame;
    CGRect leftButtonFrame = self.leftAccessoryButton.frame;
    CGRect rightButtonFrame = self.rightAccessoryButton.frame;
    CGRect textViewFrame = self.textInputView.frame;
    
    if (!self.leftAccessoryButton) {
        leftButtonFrame.size.width = 0;
    } else {
        listButtonFrame.size.width = ATLLeftAccessoryButtonWidth;
        leftButtonFrame.size.width = ATLLeftAccessoryButtonWidth;
    }
    
    // This makes the input accessory view work with UISplitViewController to manage the frame width.
    if (self.containerViewController) {
        CGRect windowRect = [self.containerViewController.view.superview convertRect:self.containerViewController.view.frame toView:nil];
        frame.size.width = windowRect.size.width;
        frame.origin.x = windowRect.origin.x;
    }
    
    // Kevin Coleman: List button must offset the default `leftAccessoryButton`.
    listButtonFrame.size.height = ATLButtonHeight;
    listButtonFrame.origin.x = ATLLeftButtonHorizontalMargin;
    
    leftButtonFrame.size.height = ATLButtonHeight;
    leftButtonFrame.origin.x = listButtonFrame.origin.x + listButtonFrame.size.width ;
    
    if (self.rightAccessoryButtonFont && (self.textInputView.text.length || !self.displaysRightAccessoryImage)) {
        rightButtonFrame.size.width = CGRectIntegral([ATLLocalizedString(@"atl.messagetoolbar.send.key", self.rightAccessoryButtonTitle, nil) boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: self.rightAccessoryButtonFont} context:nil]).size.width + ATLRightAccessoryButtonPadding;
    } else {
        rightButtonFrame.size.width = ATLRightAccessoryButtonDefaultWidth;
    }
    
    rightButtonFrame.size.height = ATLButtonHeight;
    rightButtonFrame.origin.x = CGRectGetWidth(frame) - CGRectGetWidth(rightButtonFrame) - ATLRightButtonHorizontalMargin;
    
    textViewFrame.origin.x = CGRectGetMaxX(leftButtonFrame) + ATLLeftButtonHorizontalMargin;
    textViewFrame.origin.y = self.verticalMargin;
    textViewFrame.size.width = CGRectGetMinX(rightButtonFrame) - CGRectGetMinX(textViewFrame) - ATLRightButtonHorizontalMargin;
    
    self.dummyTextView.attributedText = self.textInputView.attributedText;
    CGSize fittedTextViewSize = [self.dummyTextView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), MAXFLOAT)];
    textViewFrame.size.height = ceil(MIN(fittedTextViewSize.height, self.textViewMaxHeight));
    
    frame.size.height = CGRectGetHeight(textViewFrame) + self.verticalMargin * 2;
    frame.origin.y -= frame.size.height - CGRectGetHeight(self.frame);
    
    // Only calculate button centerY once to anchor it to bottom of bar.
    if (!self.buttonCenterY) {
        self.buttonCenterY = (CGRectGetHeight(frame) - CGRectGetHeight(leftButtonFrame)) / 2;
    }
    listButtonFrame.origin.y = frame.size.height - listButtonFrame.size.height - self.buttonCenterY;
    leftButtonFrame.origin.y = frame.size.height - leftButtonFrame.size.height - self.buttonCenterY;
    rightButtonFrame.origin.y = frame.size.height - rightButtonFrame.size.height - self.buttonCenterY;
    
    BOOL heightChanged = CGRectGetHeight(textViewFrame) != CGRectGetHeight(self.textInputView.frame);
    
    self.listAccessoryButton.frame = listButtonFrame;
    self.leftAccessoryButton.frame = leftButtonFrame;
    self.rightAccessoryButton.frame = rightButtonFrame;
    self.textInputView.frame = textViewFrame;
    
    // Setting one's own frame like this is a no-no but seems to be the lesser of evils when working around the layout issues mentioned above.
    self.frame = frame;
    
    if (heightChanged) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ATLMessageInputToolbarDidChangeHeightNotification object:self];
    }
}

- (void)listButtonTapped:(UIButton *)sender
{
    if ([self.customDelegate respondsToSelector:@selector(messageInputToolbar:didTapListAccessoryButton:)]) {
        [self.customDelegate messageInputToolbar:self didTapListAccessoryButton:sender];
    }
}

@end
