//
//  BOTCollectionViewFooterCell.h
//  Staples
//
//  Created by Kevin Coleman on 10/31/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const BOTCollectionViewFooterCellReuseIdentifier;

@interface BOTCollectionViewFooterCell : UICollectionViewCell

- (void)updateWithTitle:(NSString *)title;

+ (NSString *)reuseIdentifier;

@end
