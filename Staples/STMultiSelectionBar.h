//
//  STMultiSelectionBar.h
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STMultiSelectionBar;

@protocol STMultiSelectionBarDelegate

- (void)multiSelectionBar:(STMultiSelectionBar *)bar leftSelectionHitWithTitle:(NSString *)title;
- (void)multiSelectionBar:(STMultiSelectionBar *)bar rightSelectionHitWithTitle:(NSString *)title;

@end

@interface STMultiSelectionBar : UIControl



// Selection Delegate
@property (nonatomic, weak) id <STMultiSelectionBarDelegate> delegate;

@end
