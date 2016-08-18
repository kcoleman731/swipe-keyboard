//
//  STActionInputView.h
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STActionInputView;

@protocol STActionInputViewDelegate <NSObject>

- (void)actionInputView:(STActionInputView *)actionInputView didSelectItem:(NSString *)item;

@end

@interface STActionInputView : UIView

- (id)initWithButtonItems:(NSArray *)buttonItems;

@property (nonatomic) id<STActionInputViewDelegate> delegate;

@end
