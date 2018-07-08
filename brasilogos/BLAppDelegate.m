//
//  BLAppDelegate.m
//  brasilogos
//
//  Created by Tiago Bencardino on 03/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLAppDelegate.h"
#import "BLInAppManager.h"
#import "BLJSONDatabase.h"
#import "Flurry.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Firebase/Firebase.h>

@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
//#ifndef DEBUG
    [self loadServices];
//#endif
    [BLStyling appearances];
    [BLInAppManager shared]; // this is to, as soon as possible, activate goods to receive from app store
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [BLJSONDatabase shared];
        [BLDatabaseManager migrateIfNeeded];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        [BLBannerManager shared];
    });

    [self preloadKeyboard];
    [self preloadPrices];

    [self startCoordinator];
    return YES;
}
- (void)startCoordinator {

    self.coordinator = [[ApplicationCoordinator alloc] initWithWindow: self.window];
    [self.coordinator start];
}

- (void)loadServices {

    [Flurry startSession:@"YOUR_FLURRY_ID"];
    [Fabric with:@[[Crashlytics class]]];
    [FIRApp configure];
}

// TODO: Verify if still need this method
- (void)preloadKeyboard {

    // Preloads keyboard so there's no lag on initial keyboard appearance.
    UITextField *lagFreeField = [[UITextField alloc] init];
    [self.window addSubview:lagFreeField];
    [lagFreeField becomeFirstResponder];
    [lagFreeField resignFirstResponder];
    [lagFreeField removeFromSuperview];
}

- (void)preloadPrices {

    [[BLInAppManager shared] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        // :)
    }];
}
@end
