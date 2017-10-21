//
//  BLController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 14/09/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLController.h"
#import "BLShoppingOverlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation BLController

+ (void)playSound:(NSString*)name type:(NSString*)type {
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

+ (BOOL)isIpad {
    
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (void)showShoppingOnViewController:(UIViewController<BLInAppManagerDelegate>*)viewController {
    
    BLShoppingOverlayViewController *shopVC = [viewController.storyboard instantiateViewControllerWithIdentifier:@"BLShoppingOverlayViewController"];
    shopVC.delegate = viewController;
    
    shopVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [viewController presentViewController:shopVC animated:NO completion:nil];
}

@end
