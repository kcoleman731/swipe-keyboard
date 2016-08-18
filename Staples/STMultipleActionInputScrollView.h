//
//  STMultipleActionInputView.h
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STMultipleActionInputScrollView;

@protocol STMultipleActionInputScrollViewDelegate <NSObject>

- (void)actionInputScrollView:(STMultipleActionInputScrollView *)actionInputView didSelectItem:(NSString *)item;

@end

@interface STMultipleActionInputScrollView : UIScrollView

@property (nonatomic, weak) id <STMultipleActionInputScrollViewDelegate> actionScrollViewDelegate;

/**
 *  Convenience Init
 */
- (instancetype)initWithButtonTitles:(NSArray *)titles;

/**
 *  Setting Titles / Sub-Action Views
 */
- (void)setOptionTitles:(NSArray <NSString *> *)optionTitles;

/**
 *  Return the number of scrollable pages for the scroll view
 */
- (NSInteger)numberOfPages;

@end
