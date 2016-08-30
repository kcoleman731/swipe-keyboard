//
//  STActionButton.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "BOTActionButton.h"

@implementation BOTActionButton

+ (instancetype)initWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin];
        [self setTitle:title forState:UIControlStateNormal];
        UIColor *blue = [UIColor colorWithRed:118.0f/255.0f green:170.0f/255.0f blue:227.0f/255.0f alpha:1.0];
        [self setTitleColor:blue forState:UIControlStateNormal];
    }
    return self;
}
@end
