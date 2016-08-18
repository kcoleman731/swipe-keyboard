//
//  STMultipleActionInputView.h
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STMultipleActionInputViewDelegate <NSObject>

- (void)actionWasHitWithTitle:(NSString *)title;

@end

@interface STMultipleActionInputView : UIScrollView

@property (nonatomic, weak) id <STMultipleActionInputViewDelegate> delgate;

/**
 *  Convenience Init
 */
- (instancetype)initWithButtonTitles:(NSArray *)titles;

/**
 *  Setting Titles / Sub-Action Views
 */
- (void)setOptionTitles:(NSArray<NSString *> *)optionTitles;

@end
