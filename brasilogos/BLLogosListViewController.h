//
//  BLLogosListViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 07/02/16.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLLogosListViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, BLBannerManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *adBanner;

@property NSArray *logos;
@property NSInteger current;

@end
