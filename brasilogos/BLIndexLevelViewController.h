//
//  BLIndexLevelViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLIndexLevelViewController : UIViewController <UITableViewDataSource, BLBannerManagerDelegate>


@property (weak, nonatomic) IBOutlet UIView *adBanner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *coinsLabel;

@end
