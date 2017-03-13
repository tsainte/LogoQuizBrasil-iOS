//
//  BLBannerManager.h
//  brasilogos
//
//  Created by Tiago Bencardino on 17/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMobileAds;

@protocol BLBannerManagerDelegate <NSObject>

@required
- (void)bannerWillAppear:(UIView*)banner;
- (void)bannerWillDisappear:(UIView*)banner;

@optional
- (void)dismissScreen:(UIView*)banner;

@end

@interface BLBannerManager : NSObject <GADBannerViewDelegate, GADInterstitialDelegate>

@property id<BLBannerManagerDelegate> delegate;

+ (BLBannerManager *)shared;

- (void)showInterstitialOnViewController:(UIViewController*)viewController;

- (void)resetAdView:(id<BLBannerManagerDelegate>)viewController;

@end
