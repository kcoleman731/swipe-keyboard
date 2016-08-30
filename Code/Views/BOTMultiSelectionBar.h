//
//  STMultiSelectionBar.h
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BOTMultiSelectionBar;

@protocol BOTMultiSelectionBarDelegate

- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar leftSelectionHitWithTitle:(NSString *)title;
- (void)multiSelectionBar:(BOTMultiSelectionBar *)bar rightSelectionHitWithTitle:(NSString *)title;

@end

@interface BOTMultiSelectionBar : UIControl

// Selection Delegate
@property (nonatomic, weak) id <BOTMultiSelectionBarDelegate> delegate;

// Setters for Title
- (void)setLeftSelectionTitle:(NSString *)leftSelectionTitle
          rightSelectionTitle:(NSString *)rightSelectionTitle;

@end
