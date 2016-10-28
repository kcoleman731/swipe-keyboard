//
//  STMultipleActionInputView.m
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTMultipleActionInputView.h"
#import "BOTMultipleActionInputScrollView.h"
#import "EDColor.h"
#import "BOTUtilities.h"

static const CGFloat PAGING_CONTROL_DEFAULT_HEIGHT = 30.0f;

@interface BOTMultipleActionInputView () <BOTMultipleActionInputScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) BOTMultipleActionInputScrollView *inputScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSLayoutConstraint *pagingHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *multiSelectionBottomConstraint;

@end

@implementation BOTMultipleActionInputView

#pragma mark Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithTitles:nil actions:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitWithTitles:nil actions:nil];
    }
    return self;
}

- (instancetype)initWithSelectionTitles:(NSArray *)titles actions:(NSArray *)actions
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInitWithTitles:titles actions:nil];
    }
    return self;
}

- (void)commonInitWithTitles:(NSArray *)titles actions:(NSArray *)actions
{
    self.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
    
    self.inputScrollView = [[BOTMultipleActionInputScrollView alloc] initWithSelectionTitles:titles actions:actions];
    self.inputScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputScrollView.delegate = self;
    self.inputScrollView.actionInputScrollViewDelegate = self;
    [self addSubview:self.inputScrollView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    self.pageControl.numberOfPages = self.inputScrollView.numberOfPages;
    self.pageControl.pageIndicatorTintColor = BOTLightGrayColor();
    self.pageControl.currentPageIndicatorTintColor = BOTBlueColor();
    self.pageControl.currentPageIndicatorTintColor = self.tintColor;
    [self addSubview:self.pageControl];
    
    [self configureLayoutConstraints];
    [self displayPagingControl:self.inputScrollView.numberOfPages > 1];
}

#pragma mark Selection Item Configuration

- (void)setSelectionTitles:(NSArray <NSString *> *)titles actions:(NSArray<NSString *> *)actions
{
    [self.inputScrollView setSelectionTitles:titles actions:actions];
    self.pageControl.numberOfPages = self.inputScrollView.numberOfPages;
    [self displayPagingControl:self.inputScrollView.numberOfPages > 1];
}

#pragma mark Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

#pragma mark STMultipleActionScrollViewDelegate
- (void)actionInputScrollView:(BOTMultipleActionInputScrollView *)actionInputView didSelectTitle:(NSString *)title action:(NSString *)action
{
    [self.delegate multipleActionInputView:self didSelectTitle:title actions:action];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


#pragma mark Auto Layout

- (void)configureLayoutConstraints
{
    // Input Scroll View Constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    self.multiSelectionBottomConstraint = [NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-PAGING_CONTROL_DEFAULT_HEIGHT];
    [self addConstraint:self.multiSelectionBottomConstraint];
    
    // Page Control Constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    self.pagingHeightConstraint = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PAGING_CONTROL_DEFAULT_HEIGHT];
    [self addConstraint:self.pagingHeightConstraint];
}

- (void)displayPagingControl:(BOOL)displayControl
{
    CGFloat toPageControlHeight          = 0.0;
    CGFloat toMultiSelectionBottomOffset = -PAGING_CONTROL_DEFAULT_HEIGHT / 2.0;
    BOOL pagingVisible                   = NO;
    if (displayControl) {
        pagingVisible                        = YES;
        return;
    }

    // Set constants and relayout
    self.pagingHeightConstraint.constant         = toPageControlHeight;
    self.multiSelectionBottomConstraint.constant = toMultiSelectionBottomOffset;
    self.pageControl.hidden                      = !pagingVisible;
}

@end
