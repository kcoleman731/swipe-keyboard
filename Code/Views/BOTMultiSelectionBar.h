//
//  STMultiSelectionBar.h
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BOTMultiSelectionBar;

/**
 The `BOTMultiSelectionBarDelegate` protocol provides for informing object when selections have been made in the `BOTMultiSelectionBar`.
 */
@protocol BOTMultiSelectionBarDelegate

/**
 Informs the delegate that the user has tapped the left selection button.
 
 @param bar The `BOTMultiSelectionBar` instance in which the tap occured.
 @param title The title of the button that was tapped.
 */
- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar leftSelectionHitWithTitle:(NSString *)title;

/**
 Informs the delegate that the user has tapped the right selection button.
 
 @param bar The `BOTMultiSelectionBar` instance in which the tap occured.
 @param title The title of the button that was tapped.
 */
- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar rightSelectionHitWithTitle:(NSString *)title;

@end

/**
 The `BOTMultiSelectionBar` provides a view that can be displayed above a message input toolbar that provides for two dynamic buttons and user actions.
 */
@interface BOTMultiSelectionBar : UIControl

/**
 Selection delegate for the `BOTMultiSelectionBar`.
 */
@property (nonatomic, weak) id <BOTMultiSelectionBarDelegate> delegate;

/**
 Configures the left and right button titles for the `BOTMultiSelectionBar`.
 */
- (void)setLeftSelectionTitle:(NSString *)leftSelectionTitle rightSelectionTitle:(NSString *)rightSelectionTitle;

@end
