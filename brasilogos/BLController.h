//
//  BLController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 14/09/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface BLController : NSObject

+ (BOOL)isIphone5;

+ (BOOL)isIpad;

+ (void)playSound:(NSString*)name type:(NSString*)type;

+ (void)showShoppingOnViewController:(UIViewController*)viewController;

@end
