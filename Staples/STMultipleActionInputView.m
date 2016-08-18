//
//  STMultipleActionInputView.m
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STMultipleActionInputView.h"
#import "STMultipleActionInputScrollView.h"

@interface STMultipleActionInputView () <STMultipleActionInputScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) STMultipleActionInputScrollView *inputScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation STMultipleActionInputView

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

- (instancetype)initWithButtonTitles:(NSArray *)titles
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInitWithTitles:titles];
    }
    return self;
}

- (void)commonInitWithTitles:(NSArray *)titles
{
    [self layoutScrollViewWithTitles:titles];
    [self layoutPagingIndicatorView];
}

- (void)layoutScrollViewWithTitles:(NSArray *)titles
{
    self.inputScrollView = [[STMultipleActionInputScrollView alloc] initWithButtonTitles:titles];
    self.inputScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputScrollView.tintColor = self.tintColor;
    self.inputScrollView.delegate = self;
    [self addSubview:self.inputScrollView];
    
    // Layout Constraints
    NSLayoutConstraint *midLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.inputScrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    [self addConstraints:@[bottomConstraint, midLayoutConstraint, heightConstraint, widthConstraint]];
}

- (void)layoutPagingIndicatorView
{
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    self.pageControl.tintColor = self.tintColor;
    self.pageControl.numberOfPages = self.inputScrollView.numberOfPages;
    [self addSubview:self.pageControl];
    
    // Layout Constraints
    NSLayoutConstraint *midLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    
    [self addConstraints:@[bottomConstraint, midLayoutConstraint, heightConstraint, widthConstraint]];
}

/**
 *  Override for setting tint
 */

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.pageControl.tintColor = tintColor;
    self.inputScrollView.tintColor = tintColor;
}

/**
 *  Setter for titles
 */

- (void)setOptionTitles:(NSArray <NSString *> *)optionTitles
{
    [self.inputScrollView setOptionTitles:optionTitles];
    self.pageControl.numberOfPages = self.inputScrollView.numberOfPages;
}

/**
 *  UIScrollView Delegate
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

/**
 *  STMultipleActionScrollViewDelegate
 */
- (void)actionInputScrollView:(STMultipleActionInputScrollView *)actionInputView didSelectItem:(NSString *)item
{
    [self.delegate actionInputView:self didSelectItem:item];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
