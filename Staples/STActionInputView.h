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
 @abstract The `STActionInputViewDelegate` notifies its receiver when a selection has been made.
 */
@protocol STActionInputViewDelegate <NSObject>

/**
 @abstract Notifies the receiver that an item has been selected.
 @param actionInputView The `STActionInputView` instance.
 @return item The `NSString` representing the item that was selected.
 */
- (void)actionInputView:(STActionInputView *)actionInputView didSelectItem:(NSString *)item;

@end

/** 
 @abstract The `STActionInputView` provides an input view that can be used to display dynamic selections to a user in place of a keyboard.
 */
@interface STActionInputView : UIView

/**
 @abstract Initialiazes an `STActionInputView`.
 @param selectionItems An `NSArray` of `NSString` objects representing the selection items to be displayed in the input view.
 @return An initialized `STActionInputView`.
 */
- (id)initWithSelectionItems:(NSArray *)selectionItems;

/**
 @abstract Updates the selectionItems for the reciever.
 @param selectionItems An `NSArray` of `NSString` objects representing the selection items to be displayed in the input view.
 */
- (void)updateSelectionItems:(NSArray *)selectionItems;

/**
 @abstract The delegate object for the input view.
 */
@property (nonatomic, weak) id<STActionInputViewDelegate> delegate;

@end
