//
//  BLLogosListViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 07/02/16.
//  Copyright © 2016 MobWiz. All rights reserved.
//

#import "BLBaseViewController.h"

@protocol BLLogosListViewControllerDelegate <NSObject>

- (void)refreshUI;

@end

@interface BLLogosListViewController : BLBaseViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, BLBannerManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *adBanner;
@property (weak, nonatomic) IBOutlet UILabel *coinsLabel;

@property NSArray *logos;
@property NSInteger current;

@end
