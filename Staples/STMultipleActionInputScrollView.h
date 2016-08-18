//
//  STMultipleActionInputView.h
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STMultipleActionInputScrollView;

/**
 The `STMultipleActionInputScrollViewDelegate` notifies its receiver when a selection has been made.
 */
@protocol STMultipleActionInputScrollViewDelegate <NSObject>

/**
 Notifies the receiver that an item has been selected.
 
 @param actionInputScrollView The `STMultipleActionInputScrollView` instance.
 @param item The selection item that was selected.
 */
- (void)actionInputScrollView:(STMultipleActionInputScrollView *)actionInputScrollView didSelectItem:(NSString *)item;

@end

/**
 The `STMultipleActionInputScrollView` provides for displaying multiple `STActionInputViews`.
 */
@interface STMultipleActionInputScrollView : UIScrollView

/**
 The delegate for the instance.
 */
@property (nonatomic, weak) id <STMultipleActionInputScrollViewDelegate> actionInputScrollViewDelegate;

/**
 Initailizes an `STMultipleActionInputScrollView`.
 
 @param items An array of `NSStrings` representing the titles to be displayed for each selection.
 */
- (instancetype)initWithSelectionItems:(NSArray *)items;

/**
 Sets the selection items for the view.
 
 @param titles An array of `NSStrings` representing the titles to be displayed for each selection.
 
 @discussion Setting selection items will remove any existing items from the view.
 */
- (void)setSelectionItems:(NSArray <NSString *> *)items;

/**
 *  Return the number of scrollable pages for the scroll view
 */
- (NSInteger)numberOfPages;

@end
