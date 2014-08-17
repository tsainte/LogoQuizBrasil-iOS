//
//  BLLevelViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLLevelViewController : UIViewController <UICollectionViewDataSource>

@property NSArray* logos;
@property NSInteger levelID;
@property (weak, nonatomic) IBOutlet UILabel *coinsLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
