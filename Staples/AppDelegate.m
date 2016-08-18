//
//  AppDelegate.m
//  Staples
//
//  Created by Kevin Coleman on 8/18/16.
//  Copyright © 2016 Mesh. All rights reserved.
//

#import "AppDelegate.h"
#import <LayerKit/LayerKit.h>
#import "STConversationViewController.h"

@interface AppDelegate () <LYRClientDelegate>

@property (nonatomic) LYRClient *layerClient;
@property (nonatomic) NSURL *appID;
@property (nonatomic) NSString *userID;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *appID = [NSURL URLWithString:@"layer:///apps/staging/b816989e-040f-11e5-8d83-84d0be0060b5"];
    self.appID = appID;
    self.userID = @"test";
    self.layerClient = [LYRClient clientWithAppID:appID delegate:self options:nil];
    [self connectLayerIfNeeded];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    STConversationViewController *controller = [STConversationViewController conversationViewControllerWithLayerClient:self.layerClient];
    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:controller];
    
    self.window = [UIWindow new];
    self.window.frame = [[UIScreen mainScreen] bounds];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)connectLayerIfNeeded
{
    [self.layerClient connectWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Layer Connected!");
        } else {
            NSLog(@"Layer connecting failed with error.");
        }
        [self authenticateLayerIfNeeded];
    }];
}

- (void)authenticateLayerIfNeeded
{
    if (!self.layerClient.authenticatedUser) {
        [self.layerClient requestAuthenticationNonceWithCompletion:^(NSString * _Nullable nonce, NSError * _Nullable error) {
            if (nonce) {
                [self requestAuthenticationTokenWithNonce:nonce completion:^(NSString *token, NSError *error) {
                    if (token) {
                        [self.layerClient authenticateWithIdentityToken:token completion:^(LYRIdentity * _Nullable authenticatedUser, NSError * _Nullable error) {
                            if (authenticatedUser) {
                                NSLog(@"We good");
                            } else {
                                NSLog(@"Failed to auth with error: %@", error);
                            }
                        }];
                    } else {
                        NSLog(@"Failed to request auth token with error: %@", error);
                    }
                }];
            } else {
                NSLog(@"Failed to request nonce with error: %@", error);
            }
        }];
    }
}

- (void)requestAuthenticationTokenWithNonce:(NSString *)nonce completion:(void(^)(NSString *token, NSError *error))completion
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
        
        // Deserialize the response
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (![responseObject valueForKey:@"error"]) {
            NSString *identityToken = responseObject[@"identity_token"];
            completion(identityToken, nil);
        } else {
            NSString *domain = @"layer-identity-provider.herokuapp.com";
            NSInteger code = [responseObject[@"status"] integerValue];
            NSDictionary *userInfo =
            @{
              NSLocalizedDescriptionKey: @"Layer Identity Provider Returned an Error.",
              NSLocalizedRecoverySuggestionErrorKey: @"There may be a problem with your APPID."
              };
            
            NSError *error = [[NSError alloc] initWithDomain:domain code:code userInfo:userInfo];
            completion(nil, error);
        }
        
    }] resume];
}

- (void)layerClient:(LYRClient *)client didReceiveAuthenticationChallengeWithNonce:(NSString *)nonce
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
