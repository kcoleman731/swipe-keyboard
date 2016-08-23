//
//  STLayerService.m
//  Staples
//
//  Created by Kevin Coleman on 8/22/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "STLayerService.h"

@interface STLayerService () <NSURLSessionDelegate>

@property (nonatomic) NSString *token;
@property (nonatomic) NSURL *appID;
@property (nonatomic) NSString *userID;
@property (nonatomic) NSURLSession *session;

@end

@implementation STLayerService

+ (instancetype)serviceWithAppID:(NSURL *)appID apiToken:(NSString *)token userID:(NSString *)userID
{
    return [[self alloc] initWithAppID:appID apiToken:token userID:userID];
}

- (id)initWithAppID:(NSURL *)appID apiToken:(NSString *)token userID:(NSString *)userID
{
    self = [super init];
    if (self) {
        _token = token;
        _appID = appID;
        _userID = userID;
        _session = [NSURLSession sessionWithConfiguration:[self defaultConfiguration] delegate:self delegateQueue:nil];
    }
    return self;
}

- (NSURLSessionConfiguration *)defaultConfiguration
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type" : @"application/json", @"Accept" : @"application/vnd.layer+json; version=1.0", @"Authorization" : [NSString stringWithFormat:@"Bearer %@", self.token] };
    return configuration;
}

- (void)authenticationTokenWithNonce:(NSString *)nonce completion:(void(^)(NSString *token, NSError *error))completion
{
    NSURL *identityTokenURL = [NSURL URLWithString:@"https://layer-identity-provider.herokuapp.com/identity_tokens"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:identityTokenURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *parameters = @{ @"app_id": [self.appID absoluteString], @"user_id": self.userID, @"nonce": nonce };
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    request.HTTPBody = requestBody;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (![responseObject valueForKey:@"error"]) {
            NSString *identityToken = responseObject[@"identity_token"];
            completion(identityToken, nil);
        } else {
            NSString *domain = @"layer-identity-provider.herokuapp.com";
            NSInteger code = [responseObject[@"status"] integerValue];
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: @"Layer Identity Provider Returned an Error.",
                                       NSLocalizedRecoverySuggestionErrorKey: @"There may be a problem with your APPID."
                                       };
            
            NSError *error = [[NSError alloc] initWithDomain:domain code:code userInfo:userInfo];
            completion(nil, error);
        }
        
    }] resume];
}

- (void)createConversation:(void(^)(NSString *conversationID, NSError *error))completion
{
    NSString *URLString = [NSString stringWithFormat:@"https://api.layer.com/apps/%@/conversations", self.appID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"POST";

    NSDictionary *body = @{ @"participants": @[], @"distinct" :@(NO), @"metadata" : @{}};
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = jsonData;
    
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return;
        }
        
        NSError *jsonError;
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (![responseObject valueForKey:@"error"]) {
            NSString *conversationID = responseObject[@"id"];
            completion(conversationID, nil);
        } else {
            completion(@"", error);
        }
        
    }] resume];
}

- (void)sendPlatformMessageWithParams:(NSDictionary *)params toConversationID:(NSString *)conversationID
{
    NSString *token;
    NSURL *identityTokenURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.layer.com/apps/%@/conversations/%@/messages", self.appID, conversationID]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:identityTokenURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/vnd.layer+json; version=1.1" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];

    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    request.HTTPBody = requestBody;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return;
        }
        
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (![responseObject valueForKey:@"error"]) {
            NSLog(@"Response %@", responseObject);
        } else {
            NSLog(@"Response %@", responseObject);
        }
    }] resume];
}

@end
