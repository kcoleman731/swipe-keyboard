//
//  STMultipleActionInputView.h
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BOTMultipleActionInputView;

/**
 The `STMultipleActionInputViewDelegate` notifies its receiver when a selection has been made.
 */
@protocol BOTMultipleActionInputViewDelegate <NSObject>

/**
 Notifies the receiver that an item has been selected.
 
 @param multipleActionInputView The `STMultipleActionInputView` instance.
 @param item The selection item that was selected.
 */
- (void)multipleActionInputView:(BOTMultipleActionInputView *)multipleActionInputView didSelectTitle:(NSString *)title actions:(NSString*)action;

@end

/**
 The `STMultipleActionInputView` provides for displaying a scroll view will multiple `STActionInputViews` in place of a keyboard.
 */
@interface BOTMultipleActionInputView : UIControl

/**
 The delegate for the instance.
 */
@property (nonatomic, weak) id <BOTMultipleActionInputViewDelegate> delegate;

/**
 Initailizes an `STMultipleActionInputView`.
 
 @param items An array of `NSStrings` representing the titles to be displayed for each selection.
 */
- (instancetype)initWithSelectionTitles:(NSArray *)titles actions:(NSArray*)actions;


/**
 Sets the selection titles for the view.
 
 @param items An array of `NSStrings` representing the titles to be displayed for each selection.
 
 @discussion Setting selection titles will remove any existing titles from the view.
 */
- (void)setSelectionTitles:(NSArray <NSString *> *)titles actions:(NSArray<NSString *> *)actions;

@end
