//
//  STReorderCollectionViewCell.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Atlas/Atlas.h>

extern NSString *const BOTReorderCollectionViewCellTitle;
extern NSString *const BOTReorderCollectionViewCellMimeType;
extern NSString *const BOTReorderCollectionViewCellReuseIdentifier;

@interface BOTReorderCollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;

@end
