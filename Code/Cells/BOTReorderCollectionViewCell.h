//
//  STReorderCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>

/**
 The title of the cell. Used for testing purposes.
 */
extern NSString *const BOTReorderCollectionViewCellTitle;

/**
 The MIMEType used for message parts that should display the cell.
 */
extern NSString *const BOTReorderCollectionViewCellMimeType;

/**
 The reuse identifier for the cell.
 */
extern NSString *const BOTReorderCollectionViewCellReuseIdentifier;

/**
 The `BOTReorderCollectionViewCell` displays a horizontally scrolling collection view used to display multiple `Reorder Items` within a single cell.
 */
@interface BOTReorderCollectionViewCell : UICollectionViewCell

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

/**
 Cell Height
 */
+ (CGFloat)cellHeight;

@end
