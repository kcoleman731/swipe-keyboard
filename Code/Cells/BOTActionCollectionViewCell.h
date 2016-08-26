//
//  BOTActionCollectionViewCell.h
//  
//
//  Created by Kevin Coleman on 8/25/16.
//
//

#import <Atlas/Atlas.h>

extern NSString *const BOTActionMIMEType;
extern NSString *const BOTActionCollectionViewCellReuseIdentifier;
extern NSString *const BOTActionCollectionViewCellButtonTapped;

@interface BOTActionCollectionViewCell : ATLIncomingMessageCollectionViewCell

- (CGFloat)cellHeightForMessage:(LYRMessage *)message inView:(UIView *)view;

+ (NSString *)reuseIdentifier;

@end
