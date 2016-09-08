//
//  BOTOrderStatusBaseCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 9/7/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATLMessagePresenting.h"
#import "BOTOrderStatusViewCell.h"

/**
 The title of the cell. Used for testing purposes.
 */
extern NSString *const BOTOrderStatusBaseCollectionViewCellTitle;

/**
 The MIMEType used for message parts that should display the cell.
 */
extern NSString *const BOTOrderStatusBaseCollectionViewCellMimeType;

/**
 The reuse identifier for the cell.
 */
extern NSString *const BOTOrderStatusBaseCollectionViewCellReuseIdentifier;

@interface BOTOrderStatusBaseCollectionViewCell : UICollectionViewCell <ATLMessagePresenting>

@property (nonatomic, weak) id <BOTOrderStatusViewCellDelegate> delegate;

/**
 Cell height
 */
+ (CGFloat)cellHeight;

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;


@end
