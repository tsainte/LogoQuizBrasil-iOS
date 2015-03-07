//
//  BLBannerManager.m
//  brasilogos
//
//  Created by Tiago Bencardino on 17/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLBannerManager.h"
#import <GoogleMobileAds/GADBannerView.h>

#define kAdUnitID @"***REMOVED***"
@interface BLBannerManager ()

@property GADBannerView* adMobBannerView;
@property BOOL isLoaded;
@end

@implementation BLBannerManager

+(BLBannerManager *)shared {
  static dispatch_once_t pred;
  static BLBannerManager *shared;
  // Will only be run once, the first time this is called
  dispatch_once(&pred, ^{
    shared = [[BLBannerManager alloc] init];
  });
  return shared;
}

- (id)init {
  
  if (self = [super init]) {
    if (![BLController isIpad]) {
      self.adMobBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    } else {
      self.adMobBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard];
    }
    self.isLoaded = NO;
  }
  return self;
}

- (void)resetAdView:(id<BLBannerManagerDelegate>)viewController {
  
  self.delegate = viewController;
  if (self.isLoaded) {
    
    [self.delegate bannerWillAppear:self.adMobBannerView];
  } else {
    
    [self loadAdMob];
  }
}

- (void)loadAdMob {
  
  self.adMobBannerView.delegate = self;
  self.adMobBannerView.rootViewController = ((UIViewController*)_delegate);
  self.adMobBannerView.adUnitID = kAdUnitID;
  
  GADRequest *request = [GADRequest request];
  [self.adMobBannerView loadRequest:request];
  [((UIViewController*)_delegate).view addSubview:self.adMobBannerView];
  self.isLoaded = YES;
}

#pragma mark - AdMob Banner

- (void)adViewDidReceiveAd:(GADBannerView *)banner {

  [self.delegate bannerWillAppear:banner];
}

- (void)adView:(GADBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error {

  [self.delegate bannerWillDisappear:banner];
}
- (void)adViewDidDismissScreen:(GADBannerView *)banner {
  
  [self.delegate bannerWillDisappear:banner];
}
@end
