//
//  BLLogoViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLGameManager.h"
#import "BLLogosListViewController.h"

@interface BLLogoViewController : UIViewController <BLGameManagerDelegate, BLBannerManagerDelegate, UITextFieldDelegate, BLInAppManagerDelegate, BLLogosListViewControllerDelegate>

@property NSDictionary *logo;
@property BLGameManager *gameManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthViewConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@property (weak, nonatomic) IBOutlet UIButton *clueOneButton;
@property (weak, nonatomic) IBOutlet UIButton *clueTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *sloganButton;
@property (weak, nonatomic) IBOutlet UIButton *bombButton;
@property (weak, nonatomic) IBOutlet UIButton *magicButton;

@property (strong, nonatomic) UIViewController<BLLogosListViewControllerDelegate> *parentDelegate;

- (IBAction)clueOneTapped:(id)sender;
- (IBAction)clueTwoTapped:(id)sender;
- (IBAction)sloganTapped:(id)sender;
- (IBAction)magicTapped:(id)sender;
- (IBAction)viewDidTapped:(id)sender;

@end
