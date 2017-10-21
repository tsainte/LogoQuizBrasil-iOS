//
//  BLLevelViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLBaseViewController.h"

@interface BLLevelViewController : BLBaseViewController <UICollectionViewDataSource, BLBannerManagerDelegate, BLInAppManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *adBanner;
@property NSArray *logos;
@property NSInteger levelID;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
