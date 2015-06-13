//
//  AppDelegate.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "AppDelegate.h"
#import "OLOnboardController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - App Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setNavigationBarAppearance];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"auth"]) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        NSLog(@"No previous user session: %@", [defaults objectForKey:@"auth"]);
        OLOnboardController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                   instantiateViewControllerWithIdentifier:@"onboard"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
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

#pragma mark - Methods

- (void)setNavigationBarAppearance {
    if ([UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor darkGrayColor], NSForegroundColorAttributeName,
                                    [UIColor darkGrayColor], NSBackgroundColorAttributeName,
                                    [UIFont fontWithName:@"Avenir-Medium"
                                                    size:16],
                                    NSFontAttributeName, nil];
        [UINavigationBar appearance].titleTextAttributes = attributes;
        [UINavigationBar appearance].tintColor = [UIColor colorWithRed:0.233 green:0.480 blue:0.858 alpha:1.000];
        [UINavigationBar appearance].translucent = NO;
    }
}


@end
