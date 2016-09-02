//
//  BOTOrderCollectionViewCellProductCollectionViewCell.h
//  Staples
//
//  Created by Taylor Halliday on 9/2/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOTProduct.h"

@interface BOTOrderCollectionViewCellProductCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BOTProduct *product;

/**
 Reuse Identifier
 */
+ (NSString *)reuseIdentifier;

@end
