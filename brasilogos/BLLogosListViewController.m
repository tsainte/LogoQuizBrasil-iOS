//
//  BLLogosListViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 07/02/16.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import "BLLogosListViewController.h"
#import "BLLogoViewController.h"

@interface BLLogosListViewController ()

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation BLLogosListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadBanner];
    self.adBanner.hidden = [[BLDatabaseManager user] boughtRemoveAds];
    
    [self configurePageView];
}

- (void)configurePageView {
    
    self.pageViewController = [[self childViewControllers] firstObject];
    self.pageViewController.view.backgroundColor = [UIColor clearColor];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    
    [self.pageViewController setViewControllers:@[[self logoVCByIndex:self.current]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger current = [self.logos indexOfObject:((BLLogoViewController*)viewController).logo];
    
    if (current == 0) {
        return nil;
    } else {
        current -= 1;
        
        return [self logoVCByIndex:current];
    }
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger current = [self.logos indexOfObject:((BLLogoViewController*)viewController).logo];
    
    if (current == self.logos.count - 1) {
        return nil;
    } else {
        current += 1;
        
        return [self logoVCByIndex:current];
    }
}

- (BLLogoViewController*)logoVCByIndex:(NSInteger)index {
    
    BLLogoViewController *logoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BLLogoViewController"];
    logoVC.logo = self.logos[index];
    
    return logoVC;
}

#pragma mark - BLBannerManagerDelegate

- (void)loadBanner {
    
    [[BLBannerManager shared] resetAdView:self];
}

- (void)bannerWillAppear:(UIView *)banner {
    
    if (![self.adBanner.subviews containsObject:banner]) {
        [self.adBanner addSubview:banner];
    }
}

- (void)bannerWillDisappear:(UIView *)banner {
    
    [banner removeFromSuperview];
}


@end
