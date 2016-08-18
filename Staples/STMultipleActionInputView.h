//
//  STMultipleActionInputView.h
//  Staples
//
//  Created by Taylor Halliday on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STMultipleActionInputView;

@protocol STMultipleActionInputViewDelegate <NSObject>

- (void)actionInputView:(STMultipleActionInputView *)actionInputView didSelectItem:(NSString *)item;

@end

@interface STMultipleActionInputView : UIControl

@property (nonatomic, weak) id <STMultipleActionInputViewDelegate> delegate;

/**
 *  Convenience Init
 */
- (instancetype)initWithButtonTitles:(NSArray *)titles;

/**
 *  Setting Titles / Sub-Action Views
 */
- (void)setOptionTitles:(NSArray <NSString *> *)optionTitles;

@end
