//
//  BOTActionCollectionViewCell.h
//  
//
//  Created by Kevin Coleman on 8/25/16.
//
//

#import <Atlas/Atlas.h>

/**
 The MIMEType used for message parts that should display this cell.
 */
extern NSString *const BOTActionMIMEType;

/**
 The reuse identifier for the cell.
 */
extern NSString *const BOTActionCollectionViewCellReuseIdentifier;

/**
 Posted when the action button for the cell is tapped.
 */
extern NSString *const BOTActionCollectionViewCellButtonTapped;

/**
 The `BOTActionCollectionViewCell` displays a text message with an action button below the text. This cell is used in the BTS flow.
 */
@interface BOTActionCollectionViewCell : ATLIncomingMessageCollectionViewCell

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 */
+ (CGFloat)cellHeightForMessage:(LYRMessage *)message inView:(UIView *)view;

@end
