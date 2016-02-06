//
//  BLDetailViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 03/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *coinBig;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigVerticalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallVerticalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallHorizontalConstraint;

@end
