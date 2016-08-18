//
//  STMultipleActionInputView.h
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STMultipleActionInputView;

/**
 The `STMultipleActionInputViewDelegate` notifies its receiver when a selection has been made.
 */
@protocol STMultipleActionInputViewDelegate <NSObject>

/**
 Notifies the receiver that an item has been selected.
 
 @param multipleActionInputView The `STMultipleActionInputView` instance.
 @param item The selection item that was selected.
 */
- (void)multipleActionInputView:(STMultipleActionInputView *)multipleActionInputView didSelectItem:(NSString *)item;

@end

/**
 The `STMultipleActionInputView` provides for displaying a scroll view will multiple `STActionInputViews` in place of a keyboard.
 */
@interface STMultipleActionInputView : UIControl

/**
 The delegate for the instance.
 */
@property (nonatomic, weak) id <STMultipleActionInputViewDelegate> delegate;

/**
 Initailizes an `STMultipleActionInputView`.
 
 @param items An array of `NSStrings` representing the titles to be displayed for each selection.
 */
- (instancetype)initWithSelectionItems:(NSArray *)items;

/**
 Sets the selection titles for the view.
 
 @param items An array of `NSStrings` representing the titles to be displayed for each selection.
 
 @discussion Setting selection items will remove any existing items from the view.
 */
- (void)setSelectionItems:(NSArray <NSString *> *)items;

@end
