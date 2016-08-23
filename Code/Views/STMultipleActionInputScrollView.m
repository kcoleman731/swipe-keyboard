//
//  STMultipleActionInputView.m
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleActionInputScrollView.h"
#import "STActionInputView.h"

static const int MAX_OPTIONS_PER_PAGE = 4;

@interface STMultipleActionInputScrollView() <STActionInputViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray <STActionInputView *> *inputViews;

@end

@implementation STMultipleActionInputScrollView

#pragma mark Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithOptionTitles:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitWithOptionTitles:nil];
    }
    return self;
}

- (instancetype)initWithSelectionTitles:(NSArray *)titles
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInitWithOptionTitles:titles];
    }
    return self;
}

- (void)commonInitWithOptionTitles:(NSArray *)titles
{
    // Init iVars
    self.inputViews = @[];
    [self setSelectionTitles:titles];
    self.backgroundColor = [UIColor whiteColor];
    
    // Configure scrollview and layout input views
    self.pagingEnabled                  = YES;
    self.showsHorizontalScrollIndicator = NO;
}

#pragma mark Selection Item Configuration

- (void)setSelectionTitles:(NSArray <NSString *> *)titles
{
    // Remove any existing
    [self removeAllExistingActionViews];
    
    // Init Action Pages
    NSInteger pages = titles.count / MAX_OPTIONS_PER_PAGE;
    NSMutableArray *actionViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < pages; i++) {
        
        // Create action input view w/ subsection of titles
        NSInteger begIdx                   = i * MAX_OPTIONS_PER_PAGE;
        BOOL idxCanHandleAllOptions        = titles.count >= begIdx + MAX_OPTIONS_PER_PAGE;
        NSInteger length                   = idxCanHandleAllOptions ? MAX_OPTIONS_PER_PAGE : titles.count - MAX_OPTIONS_PER_PAGE;
        NSRange subRange                   = NSMakeRange(begIdx, length);
        NSArray *subSectionOfTitles        = [titles subarrayWithRange:subRange];
        
        STActionInputView *actionInputView = [[STActionInputView alloc] initWithSelectionTitles:subSectionOfTitles];
        actionInputView.tintColor          = self.tintColor;
        actionInputView.delegate           = self;
        
        // Setup layout
        [self addSubview:actionInputView];
        [actionViews addObject:actionInputView];
    }
    
    // Set Input Views and Call a layout
    self.inputViews = [actionViews copy];
    [self setNeedsLayout];
}

- (void)removeAllExistingActionViews
{
    for (STActionInputView *inputView in self.inputViews) {
        [inputView removeFromSuperview];
    }
    self.inputViews = @[];
}

#pragma mark View Layout

- (void)layoutSubviews
{
    // Hooking here to setup the proper paging based on the number of input views.
    [super layoutSubviews];
    [self configureScrollableArea];
    [self layoutInputViews];
}

- (void)configureScrollableArea
{
    NSInteger pages  = self.inputViews.count;
    CGFloat width    = pages * self.bounds.size.width;
    self.contentSize = CGSizeMake(width, self.bounds.size.height);
}

- (void)layoutInputViews
{
    const CGFloat ACTION_VIEW_INSET = 10.0;
    for (int i = 0; i < self.inputViews.count; i++) {
        // Generate inset rect based on page
        CGFloat pageBegIdx     = self.frame.size.width * i;
        CGRect inputViewRect   = CGRectMake(pageBegIdx, 0.0, self.frame.size.width, self.frame.size.height);
        inputViewRect          = CGRectInset(inputViewRect, ACTION_VIEW_INSET, ACTION_VIEW_INSET * 2.0);
        inputViewRect.origin.y = ACTION_VIEW_INSET;
        
        STActionInputView *inputView = self.inputViews[i];
        [inputView setFrame:inputViewRect];
    }
}

#pragma mark Page Count

- (NSInteger)numberOfPages
{
    return self.inputViews.count;
}

#pragma mark STActionInputViewDelegate

- (void)actionInputView:(STActionInputView *)actionInputView didSelectTitle:(NSString *)title
{
    [self.actionInputScrollViewDelegate actionInputScrollView:self didSelectTitle:title];
}

@end
