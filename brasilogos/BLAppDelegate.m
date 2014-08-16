//
//  BLAppDelegate.m
//  brasilogos
//
//  Created by Tiago Bencardino on 03/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLAppDelegate.h"
#import <TestFlightSDK/TestFlight.h>
#import <FlurrySDK/Flurry.h>
@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
      UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
      splitViewController.delegate = (id)navigationController.topViewController;
  }
  
#ifndef DEBUG
    [self loadServices];
#endif
  UIColor* color = [UIColor colorWithRed:73.0f/255.0f green:134.0f/255.0f blue:96.0f/255.0f alpha:1.0f];
  [[UITextField appearance] setTintColor:color];
  return YES;
}

- (void)loadServices {
  
  [TestFlight takeOff:@"3b94d0d3-7d4c-4b6d-b669-4952ca79a191"];
  [Flurry startSession:@"N28FGC2TJ86Q86986897"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
