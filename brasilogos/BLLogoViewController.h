//
//  BLLogoViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLGameManager.h"

@interface BLLogoViewController : UIViewController <BLGameManagerDelegate, BLBannerManagerDelegate>

@property NSDictionary* logo;
@property BLGameManager* gameManager;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *keyboard;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightPanelConstraint;
@property (weak, nonatomic) IBOutlet UILabel *coinsLabel;

@property (weak, nonatomic) IBOutlet UIButton *clueOneButton;
@property (weak, nonatomic) IBOutlet UIButton *clueTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *sloganButton;
@property (weak, nonatomic) IBOutlet UIButton *bombButton;
@property (weak, nonatomic) IBOutlet UIButton *magicButton;
@property (weak, nonatomic) IBOutlet UIView *adBanner;

- (IBAction)clueOneTapped:(id)sender;
- (IBAction)clueTwoTapped:(id)sender;
- (IBAction)sloganTapped:(id)sender;
- (IBAction)bombTapped:(id)sender;
- (IBAction)magicTapped:(id)sender;


- (IBAction)keyPressed:(UIButton *)sender;
- (IBAction)shopTapped:(id)sender;

@end
