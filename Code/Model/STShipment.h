//
//  STShipment.h
//  Pods
//
//  Created by Kevin Coleman on 8/24/16.
//
//

#import <Foundation/Foundation.h>
#import <LayerKit/LayerKit.h>

extern NSString *const STShipmentMIMEType;

@interface STShipment : NSObject

+ (instancetype)shipmentWithData:(NSDictionary *)data;

@property (nonatomic) NSString *status;
@property (nonatomic) NSDate *deliveryDate;
@property (nonatomic) NSString *number;
@property (nonatomic) NSString *boxCount;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *orderNumber;

@end
