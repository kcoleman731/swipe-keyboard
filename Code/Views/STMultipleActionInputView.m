//
//  STMultipleActionInputView.m
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleActionInputView.h"
#import "STMultipleActionInputScrollView.h"
#import "EDColor.h"

@interface STMultipleActionInputView () <STMultipleActionInputScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) STMultipleActionInputScrollView *inputScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation STMultipleActionInputView

#pragma mark Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithTitles:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitWithTitles:nil];
    }
    return self;
}

- (instancetype)initWithSelectionTitles:(NSArray *)titles
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInitWithTitles:titles];
    }
    return self;
}

- (void)commonInitWithTitles:(NSArray *)titles
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.inputScrollView = [[STMultipleActionInputScrollView alloc] initWithSelectionTitles:titles];
    self.inputScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputScrollView.delegate = self;
    self.inputScrollView.actionInputScrollViewDelegate = self;
    [self addSubview:self.inputScrollView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    self.pageControl.numberOfPages = self.inputScrollView.numberOfPages;
    self.pageControl.pageIndicatorTintColor = self.tintColor;
    self.pageControl.currentPageIndicatorTintColor = self.tintColor;
    [self addSubview:self.pageControl];
    
    [self configureLayoutConstraints];
}

#pragma mark Selection Item Configuration

- (void)setSelectionTitles:(NSArray <NSString *> *)titles
{
    [self.inputScrollView setSelectionTitles:titles];
    self.pageControl.numberOfPages = self.inputScrollView.numberOfPages;
}

#pragma mark Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

#pragma mark STMultipleActionScrollViewDelegate
- (void)actionInputScrollView:(STMultipleActionInputScrollView *)actionInputView didSelectTitle:(NSString *)title
{
    [self.delegate multipleActionInputView:self didSelectTitle:title];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark Auto Layout

- (void)configureLayoutConstraints
{
    // Input Scroll View Constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-30.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    
    // Page Control Constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
}

@end
