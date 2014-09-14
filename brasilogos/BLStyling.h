//
//  BLStyling.h
//  brasilogos
//
//  Created by Tiago Bencardino on 09/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define kColorDarkGreen [UIColor colorWithRed:73.0f/255.0f green:134.0f/255.0f blue:96.0f/255.0f alpha:1.0f]
#define kColorLightGreen [UIColor colorWithRed:171.0f/255.0f green:193.0f/255.0f blue:120.0f/255.0f alpha:1.0f]
#define kColorYellow [UIColor colorWithRed:248.0f/255.0f green:219.0f/255.0f blue:148.0f/255.0f alpha:1.0f]
#define kColorRed [UIColor colorWithRed:188.0f/255.0f green:139.0f/255.0f blue:121.0f/255.0f alpha:1.0f]

@interface BLStyling : NSObject

+ (void)appearances;
+ (void)roundView:(UIView*)view;
+ (void)roundView:(UIView*)view corner:(CGFloat)corner;

@end
