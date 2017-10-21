//
//  BLIndexLevelViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@interface BLIndexLevelViewController : BLBaseViewController <UITableViewDataSource, UITableViewDelegate, BLBannerManagerDelegate, BLInAppManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *adBanner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heigthAdBannerConstraint;

@end
