//
//  BLStyling.m
//  brasilogos
//
//  Created by Tiago Bencardino on 09/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLStyling.h"
#import <AVFoundation/AVFoundation.h>

@implementation BLStyling

+ (void)appearances {
    
    //paint textfield tint color
    [[UITextField appearance] setTintColor:kColorDarkGreen];
    //  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+ (void)roundView:(UIView*)view {
    
    [[view layer] setCornerRadius:[view frame].size.height / 2];
}

+ (void)roundView:(UIView*)view corner:(CGFloat)corner {
    
    [[view layer] setCornerRadius:corner];
}

@end
