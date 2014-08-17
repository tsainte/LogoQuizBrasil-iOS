//
//  BLShoppingOverlayViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 17/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLShoppingOverlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *overlay;
@property (weak, nonatomic) IBOutlet UIView *content;

@property (weak, nonatomic) IBOutlet UIView *coins100;
@property (weak, nonatomic) IBOutlet UIView *coins250;
@property (weak, nonatomic) IBOutlet UIView *coins750;
@property (weak, nonatomic) IBOutlet UIView *coins2000;
@property (weak, nonatomic) IBOutlet UIView *removeAds;
@property (weak, nonatomic) IBOutlet UIView *restore;

- (IBAction)overlayTapped:(id)sender;

@end
