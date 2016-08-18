//
//  STActionInputView.h
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STActionInputView;

/**
 The `STActionInputViewDelegate` notifies its receiver when a selection has been made.
 */
@protocol STActionInputViewDelegate <NSObject>

/**
 Notifies the receiver that an item has been selected.
 
 @param actionInputView The `STActionInputView` instance.
 @param item The selection title that was selected.
 */
- (void)actionInputView:(STActionInputView *)actionInputView didSelectTitle:(NSString *)title;

@end

/** 
 The `STActionInputView` provides an input view that can be used to display dynamic selections to a user in place of a keyboard.
 */
@interface STActionInputView : UIView

/**
 The delegate object for the instance.
 */
@property (nonatomic, weak) id<STActionInputViewDelegate> delegate;

/**
 Initialiazes an `STActionInputView`.
 
 @param items An `NSArray` of `NSString` objects representing the selection titles to be displayed in the input view.
 
 @return An initialized `STActionInputView`.
 */
- (id)initWithSelectionTitles:(NSArray <NSString *> *)titles;

@end
