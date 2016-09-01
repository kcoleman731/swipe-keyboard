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
#import "STLayerService.h"

@interface AppDelegate () <LYRClientDelegate>

@property (nonatomic) LYRClient *layerClient;
@property (nonatomic) STLayerService *layerService;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *userID = @"1234-1234-1234-1234";
    NSURL *appID = [NSURL URLWithString:@"layer:///apps/staging/4e426158-68b0-11e6-9b8d-cc1001002ef3"];
    self.layerService = [STLayerService serviceWithAppID:appID apiToken:@"" userID:userID];
    self.layerClient = [LYRClient clientWithAppID:appID delegate:self options:nil];
    [self connectLayer];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (self.layerClient.authenticatedUser) {
        STConversationViewController *controller = [STConversationViewController conversationViewControllerWithLayerClient:self.layerClient];
        UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:controller];
        
        self.window = [UIWindow new];
        self.window.frame = [[UIScreen mainScreen] bounds];
        self.window.rootViewController = root;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

- (void)connectLayer
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
                [self.layerService authenticationTokenWithNonce:nonce completion:^(NSString *token, NSError *error) {
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

- (void)layerClient:(LYRClient *)client didReceiveAuthenticationChallengeWithNonce:(NSString *)nonce
{
    [self.layerService authenticationTokenWithNonce:nonce completion:^(NSString *token, NSError *error) {
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
}

- (void)layerClient:(LYRClient *)client didAuthenticateAsUserID:(NSString *)userID
{
    if (![self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        STConversationViewController *controller = [STConversationViewController conversationViewControllerWithLayerClient:self.layerClient];
        UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:controller];
        
        self.window = [UIWindow new];
        self.window.frame = [[UIScreen mainScreen] bounds];
        self.window.rootViewController = root;
        [self.window makeKeyAndVisible];
    }
}

@end
