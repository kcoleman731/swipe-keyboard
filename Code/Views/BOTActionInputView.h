//
//  BOTActionInputView.h
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BOTActionInputView;

/**
 The `STActionInputViewDelegate` notifies its receiver when a selection has been made.
 */
@protocol BOTActionInputViewDelegate <NSObject>

/**
 Notifies the receiver that an item has been selected.
 
 @param actionInputView The `STActionInputView` instance.
 @param item The selection title that was selected.
 @param action The selection action that was selected.
 */
- (void)actionInputView:(BOTActionInputView *)actionInputView didSelectTitle:(NSString *)title actions:(NSString*)actions;

@end

/** 
 The `STActionInputView` provides an input view that can be used to display dynamic selections to a user in place of a keyboard.
 */
@interface BOTActionInputView : UIView

/**
 The delegate object for the instance.
 */
@property (nonatomic, weak) id<BOTActionInputViewDelegate> delegate;

/**
 Initialiazes an `STActionInputView`.
 
 @param items An `NSArray` of `NSString` objects representing the selection titles to be displayed in the input view.
 
 @return An initialized `STActionInputView`.
 */
- (id)initWithSelectionTitles:(NSArray *)titles actions:(NSArray *)actions;

@end
