//
//  STMultipleActionInputView.h
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BOTMultipleActionInputScrollView;

/**
 The `STMultipleActionInputScrollViewDelegate` notifies its receiver when a selection has been made.
 */
@protocol BOTMultipleActionInputScrollViewDelegate <NSObject>

/**
 Notifies the receiver that an title has been selected.
 
 @param actionInputScrollView The `STMultipleActionInputScrollView` instance.
 @param item The selection title that was selected.
 */
- (void)actionInputScrollView:(BOTMultipleActionInputScrollView *)actionInputScrollView didSelectTitle:(NSString *)title;

@end

/**
 The `STMultipleActionInputScrollView` provides for displaying multiple `STActionInputViews`.
 */
@interface BOTMultipleActionInputScrollView : UIScrollView

/**
 The delegate for the instance.
 */
@property (nonatomic, weak) id <BOTMultipleActionInputScrollViewDelegate> actionInputScrollViewDelegate;

/**
 Initailizes an `STMultipleActionInputScrollView`.
 
 @param items An array of `NSStrings` representing the titles to be displayed for each selection.
 */
- (instancetype)initWithSelectionTitles:(NSArray *)titles;

/**
 Sets the selection items for the view.
 
 @param titles An array of `NSStrings` representing the titles to be displayed for each selection.
 
 @discussion Setting selection titles will remove any existing titles from the view.
 */
- (void)setSelectionTitles:(NSArray <NSString *> *)titles;

/**
 *  Return the number of scrollable pages for the scroll view
 */
- (NSInteger)numberOfPages;

@end
