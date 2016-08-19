//
//  STProductModel.m
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STProductItem.h"

@implementation STProductItem

- (instancetype)initWithDictionaryPayload:(NSDictionary *)payload
{
    self = [super init];
    if (self) {
        self.picURL = payload[@"pic"];
        self.price = payload[@"price"];
        self.title = payload[@"title"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.picURL = [aDecoder decodeObjectForKey:@"pic"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.picURL forKey:@"pic"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.price forKey:@"price"];
}

@end
