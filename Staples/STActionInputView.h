//
//  STActionInputView.h
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STActionInputViewDelegate <NSObject>

- (void)actionInputViewDelegate

@end

@interface STActionInputView : UIView

- (id)initWithButtonItems:(NSArray *)buttonItems;

@end
