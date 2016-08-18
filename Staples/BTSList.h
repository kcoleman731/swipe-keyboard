//
//  BTSList.h
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BTSCardType) {
    BTSCardTypeItem,
};

@interface BTSList : NSObject

@property (nonatomic) BTSCardType cardType;
@property (nonatomic) NSArray *listItems;

@end
