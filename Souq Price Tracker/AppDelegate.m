//
//  AppDelegate.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/26/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize singlton;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Initialize the singlton object for the first and last time.
    singlton = [Singlton singlton];
    
    // Testing logging which has been configured in the singlton initialization.
    DDLogVerbose(@"Language: %@ %@", [[singlton languageDetails] language], [singlton.languageDetails LocalString:@"Language"]);
    DDLogVerbose(@"Direction is rtl: %d", [[singlton languageDetails] rtl]);
    DDLogVerbose(@"Name: %@", [[singlton userDetails] code]);
    DDLogVerbose(@"Code: %@", [[singlton userDetails] name]);
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self parseDeepLink:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [self parseDeepLink:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self parseDeepLink:url];
}

// DEEP LINKS
//https://redirect_uri/?state={state}&code={code}
- (BOOL)parseDeepLink:(NSURL *)url {
    @try {
        
        if (!url)
            return NO;
        
        DDLogVerbose(@"url recieved: %@", url);
        DDLogVerbose(@"query string: %@", [url query]);
        DDLogVerbose(@"host: %@", [url host]);
        DDLogVerbose(@"url path: %@", [url path]);
        
        NSDictionary *dict = [self parseQueryString:[url query]];
        [[singlton apiHelper] userAuthorized:[dict valueForKey:@"code"]];
        
    } @catch (NSException *exception) {
        DDLogVerbose(@"Deep Link ::::: URL Parsing Exception ::::: %@", [exception debugDescription]);
        return  NO;
    }

    return YES;
}

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
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
