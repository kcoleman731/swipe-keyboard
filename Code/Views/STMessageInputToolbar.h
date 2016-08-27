//
//  STMessageInputToolbar.h
//  Staples
//
//  Created by Kevin Coleman on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Atlas/Atlas.h>

@class STMessageInputToolbar;

@protocol STMessageInputToolbarDelegate <NSObject>

/**
 Notifies the receiver that the list accessory button was tapped.
 */
- (void)messageInputToolbar:(STMessageInputToolbar *)messageInputToolbar didTapListAccessoryButton:(UIButton *)listAccessoryButton;

/**
 Notifies the receiver that the multi selection bar was tapped
 */
- (void)messageInputToolbar:(STMessageInputToolbar *)messageInputToolbar multiSelectionBarTappedWithTitle:(NSString *)title;

@end

/**
 `STMessageInputToolbar` is a custom subclass for the `ATLMessageInputToolbar`.
 
 @discussion. The `STMessageInputToolbar` provides two accessory buttons to the left of the actual text box of the tool bar. The `ATLMessageInputToolbar` does not provide for customization of this feature, so this subclass overrides some methods in order to display the two buttons.
 */
@interface STMessageInputToolbar : ATLMessageInputToolbar

/**
 The delegate for the custom subclass.
 */
@property (nonatomic, weak) id <STMessageInputToolbarDelegate> customDelegate;

/**
 *  Setter for displaying the multi action Toolbar
 *
 */
- (void)displayMultiSelectionInputBar:(BOOL)displayBar;

@end
