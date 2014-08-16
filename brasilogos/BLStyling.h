//
//  BLStyling.h
//  brasilogos
//
//  Created by Tiago Bencardino on 09/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define kColorLightGreen [UIColor colorWithRed:73.0f/255.0f green:134.0f/255.0f blue:96.0f/255.0f alpha:1.0f]
@interface BLStyling : NSObject

+ (void)appearances;
+ (BOOL)isIphone5;
+ (void)roundView:(UIView*)view;
+ (void)roundView:(UIView*)view corner:(CGFloat)corner;

@end
