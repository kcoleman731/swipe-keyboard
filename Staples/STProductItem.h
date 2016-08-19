//
//  STProductModel.h
//  Staples
//
//  Created by Taylor Halliday on 8/19/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STProductItem : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picURL;
@property (nonatomic, strong) NSString *price;

// Convenience Init
- (instancetype)initWithDictionaryPayload:(NSDictionary *)payload;

@end
