//
//  STLayerService.h
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LayerKit/LayerKit.h>

@interface STLayerService : NSObject

+ (instancetype)serviceWithAppID:(NSURL *)appID apiToken:(NSString *)token userID:(NSString *)userID;

- (void)authenticationTokenWithNonce:(NSString *)nonce completion:(void(^)(NSString *token, NSError *error))completion;

- (void)getConversations:(void(^)(NSString *conversationID, NSError *error))completion;

- (void)createConversation:(void(^)(NSString *conversationID, NSError *error))completion;

- (void)sendPlatformMessageWithParams:(NSDictionary *)params toConversationID:(NSString *)conversationID;

@end
