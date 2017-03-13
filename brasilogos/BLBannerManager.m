//
//  BLBannerManager.m
//  brasilogos
//
//  Created by Tiago Bencardino on 17/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLBannerManager.h"


#define kAdUnitBannerID @"YOUR_AD_UNIT_BANNER_ID"
#define kAdUnitInterstitialID @"YOUR_AD_UNIT_INTERSTITIAL_ID"

@interface BLBannerManager ()

@property (nonatomic, strong) GADBannerView *adMobBannerView;
@property (nonatomic, strong) GADInterstitial *interstitial;

@property NSInteger lastInterstitialTimestamp;
@property NSInteger interstitialCount;

@property BOOL bannerIsLoaded;

@end

@implementation BLBannerManager

+ (BLBannerManager *)shared {
    
    static dispatch_once_t pred;
    static BLBannerManager * shared;
    // Will only be run once, the first time this is called
    dispatch_once(&pred, ^{
        shared = [[BLBannerManager alloc] init];
    });
    
    return shared;
}

- (id)init {
    
    if (self = [super init]) {
        
        self.lastInterstitialTimestamp = [[NSDate date] timeIntervalSince1970];
        self.interstitialCount = 0;
        
        [self initInterstitial];
        [self initBannerView];
    }
    
    return self;
}

#pragma mark - Interstitial

- (void)initInterstitial {
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:kAdUnitInterstitialID];
    self.interstitial.delegate = self;
    [self.interstitial loadRequest:[self newRequest]];
}

- (void)showInterstitialOnViewController:(UIViewController*)viewController {
    
    if (self.interstitial.isReady && [self shouldShowInterstitital]) {
        [self.interstitial presentFromRootViewController:viewController];
    }
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    
    self.interstitialCount += 1;
    self.lastInterstitialTimestamp = [[NSDate date] timeIntervalSince1970];
    
    [self initInterstitial];
}

- (BOOL)shouldShowInterstitital {
    
    NSInteger now = [[NSDate date] timeIntervalSince1970];
    NSInteger intervalSinceLastIntestitial = now - self.lastInterstitialTimestamp;
    
    return self.interstitialCount < 5 && intervalSinceLastIntestitial >= 120;
}

#pragma mark - Banner

- (void)initBannerView {
    
    if (![BLController isIpad]) {
        self.adMobBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    } else {
        self.adMobBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard];
    }
    self.bannerIsLoaded = NO;
}

- (void)resetAdView:(id<BLBannerManagerDelegate>)viewController {
    
    self.delegate = viewController;
    
    if (self.bannerIsLoaded) {
        
        [self.delegate bannerWillAppear:self.adMobBannerView];
    } else {
        
        [self loadBanner];
    }
}

- (void)loadBanner {
    
    self.adMobBannerView.delegate = self;
    self.adMobBannerView.rootViewController = ((UIViewController*)_delegate);
    self.adMobBannerView.adUnitID = kAdUnitBannerID;
    
    [self.adMobBannerView loadRequest:[self newRequest]];
    
    [((UIViewController*)_delegate).view addSubview:self.adMobBannerView];
    self.bannerIsLoaded = YES;
}

- (GADRequest*)newRequest {
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    
    return request;
}

#pragma mark - AdMob Banner delegate

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
