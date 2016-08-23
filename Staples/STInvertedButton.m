//
//  STInvertedButton.m
//  Staples
//
//  Created by Taylor Halliday on 8/23/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STInvertedButton.h"

@implementation STInvertedButton

- (void)setHighlighted:(BOOL)highlighted {
    [UIView animateWithDuration:0.08f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            if (highlighted) {
                                self.backgroundColor = self.tintColor;
                            } else {
                                self.backgroundColor = [UIColor whiteColor];
                            }
                        }
                     completion:nil];
}

@end
