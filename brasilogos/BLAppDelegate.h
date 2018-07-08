//
//  BLAppDelegate.h
//  brasilogos
//
//  Created by Tiago Bencardino on 03/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "brasilogos-Swift.h"

@class ApplicationCoordinator;

@interface BLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ApplicationCoordinator *coordinator;

@end
