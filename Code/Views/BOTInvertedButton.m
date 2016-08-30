//
//  STInvertedButton.m
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTInvertedButton.h"

@implementation BOTInvertedButton

- (void)setHighlighted:(BOOL)highlighted {
    [UIView animateWithDuration:0.08f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            if (highlighted) {
                                self.backgroundColor = [self.tintColor colorWithAlphaComponent:0.8f];
                                self.titleLabel.textColor = [UIColor whiteColor];
                            } else {
                                self.backgroundColor = [UIColor whiteColor];
                                self.titleLabel.textColor = self.tintColor;
                            }
                        }
                     completion:nil];
}

@end
