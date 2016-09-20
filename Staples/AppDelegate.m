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

NSString *const STLayerAppID = @"layer:///apps/staging/4e426158-68b0-11e6-9b8d-cc1001002ef3";

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *userID = @"1234-1234-1234-1234";
    self.layerService = [STLayerService serviceWithAppID:[NSURL URLWithString:STLayerAppID] apiToken:@"" userID:userID];
    [self connectLayer];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self connectLayer];
    g
    if (self.layerClient.authenticatedUser) {
        STConversationViewController *controller = [STConversationViewController conversationViewControllerWithLayerClient:self.layerClient];
        UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:controller];
        
        self.window = [UIWindow new];
        self.window.frame = [[UIScreen mainScreen] bounds];
        self.window.rootViewController = root;
        [self.window makeKeyAndVisible];
    }
    
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:notificationSettings];
    [application registerForRemoteNotifications];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSError *error;
    BOOL success = [self.layerClient updateRemoteNotificationDeviceToken:deviceToken error:&error];
    if (success) {
        NSLog(@"Application did register for remote notifications");
    } else {
        NSLog(@"Error updating Layer device token for push:%@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

- (LYRClient *)layerClient
{
    if (!_layerClient) {
        NSURL *appID = [NSURL URLWithString:@"layer:///apps/staging/4e426158-68b0-11e6-9b8d-cc1001002ef3"];
        _layerClient = [LYRClient clientWithAppID:appID delegate:self options:nil];
    }
    return _layerClient;
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
