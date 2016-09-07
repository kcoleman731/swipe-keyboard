//
//  BOTOrderCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 9/1/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>
#import "BOTOrder.h"


/**
 The title of the cell. Used for testing purposes.
 */
extern NSString *const BOTOrderCollectionViewCellTitle;

/**
 The MIMEType used for message parts that should display the cell.
 */
extern NSString *const BOTOrderCollectionViewCellMimeType;

/**
 The reuse identifier for the cell.
 */
extern NSString *const BOTOrderCollectionViewCellReuseIdentifier;

@interface BOTOrderCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BOTOrder *order;

/**
 Cell height
 */
+ (CGFloat)cellHeight;
    
/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

- (void)setOrder:(BOTOrder *)order;

@end
