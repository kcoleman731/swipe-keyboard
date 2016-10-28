//
//  STMultipleActionInputView.m
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTMultipleActionInputScrollView.h"
#import "BOTActionInputView.h"

static const int MAX_OPTIONS_PER_PAGE = 4.0f;

@interface BOTMultipleActionInputScrollView() <BOTActionInputViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray <BOTActionInputView *> *inputViews;

@end

@implementation BOTMultipleActionInputScrollView

#pragma mark Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithOptionTitles:nil actions:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitWithOptionTitles:nil actions:nil];
    }
    return self;
}

- (instancetype)initWithSelectionTitles:(NSArray *)titles actions:(NSArray *)actions
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInitWithOptionTitles:titles actions:actions];
    }
    return self;
}

- (void)commonInitWithOptionTitles:(NSArray *)titles actions:(NSArray *)actions
{
    // Init iVars
    self.inputViews = @[];
    [self setSelectionTitles:titles actions:actions];
    self.backgroundColor = [UIColor clearColor];
    
    // Configure scrollview and layout input views
    self.pagingEnabled                  = YES;
    self.showsHorizontalScrollIndicator = NO;
}

#pragma mark Selection Item Configuration

- (void)setSelectionTitles:(NSArray <NSString *> *)titles actions:(NSArray <NSString *> *)actions
{
    // Remove any existing
    [self removeAllExistingActionViews];
    
    // Init Action Pages
    CGFloat pages = ceilf((titles.count * 1.0f)/ MAX_OPTIONS_PER_PAGE);
    NSMutableArray *actionViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < pages; i++) {
        
        // Create action input view w/ subsection of titles
        NSInteger begIdx                   = i * MAX_OPTIONS_PER_PAGE;
        BOOL idxCanHandleAllOptions        = titles.count >= begIdx + MAX_OPTIONS_PER_PAGE;
        NSInteger length                   = idxCanHandleAllOptions ? MAX_OPTIONS_PER_PAGE : titles.count - (MAX_OPTIONS_PER_PAGE * i);
        NSRange subRange                   = NSMakeRange(begIdx, length);
        NSArray *subSectionOfTitles        = [titles subarrayWithRange:subRange];
        
        BOTActionInputView *actionInputView = [[BOTActionInputView alloc] initWithSelectionTitles:subSectionOfTitles actions:actions];
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
    for (BOTActionInputView *inputView in self.inputViews) {
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
    const CGFloat ACTION_VIEW_INSET = 15.0;
    for (int i = 0; i < self.inputViews.count; i++) {
        // Generate inset rect based on page
        CGFloat pageBegIdx     = self.frame.size.width * i;
        CGRect inputViewRect   = CGRectMake(pageBegIdx, 0.0, self.frame.size.width, self.frame.size.height);
        inputViewRect          = CGRectInset(inputViewRect, ACTION_VIEW_INSET, ACTION_VIEW_INSET / 2.0);
        inputViewRect.origin.y = ACTION_VIEW_INSET;
        
        BOTActionInputView *inputView = self.inputViews[i];
        [inputView setFrame:inputViewRect];
    }
}

#pragma mark Page Count

- (NSInteger)numberOfPages
{
    return self.inputViews.count;
}

#pragma mark STActionInputViewDelegate

- (void)actionInputView:(BOTActionInputView *)actionInputView didSelectTitle:(NSString *)title actions:(NSString *)action
{
    [self.actionInputScrollViewDelegate actionInputScrollView:self didSelectTitle:title action:action];
}

@end
