//
//  BOTCircleImageView.m
//  Pods
//
//  Created by Taylor Halliday on 9/12/16.
//
//

#import "BOTCircleImageView.h"

@implementation BOTCircleImageView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.height / 2.0;
}

@end
