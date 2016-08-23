//
//  STLayerServiceTest.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STLayerService.h"

@interface STLayerServiceTest : XCTestCase

@property (nonatomic) NSURL *appID;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *userID;
@property (nonatomic) STLayerService *service;

@end

@implementation STLayerServiceTest

- (void)setUp
{
    [super setUp];
    self.userID = [[NSUUID UUID] UUIDString];
    self.appID = [NSURL URLWithString:@"4e426158-68b0-11e6-9b8d-cc1001002ef3"];
    self.token = @"FRSZHpW1b7LLMEEUYgHaDOg3WknhcRucUnKJjx4W58ZmPfIL";
    self.service = [STLayerService serviceWithAppID:self.appID apiToken:self.token userID:self.userID];
}

- (void)testCreatingNewConversation
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Conversation Creation Expectation"];
    [self.service createConversation:^(NSString *conversationID, NSError *error) {
        if (!error) {
            [expectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testSendngMessageToConversation
{
    
}

@end
