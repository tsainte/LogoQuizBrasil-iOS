//
//  BLLogoViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLGameManager.h"

@interface BLLogoViewController : UIViewController <BLGameManagerDelegate>

@property NSDictionary* logo;
@property BLGameManager* gameManager;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *keyboard;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightPanelConstraint;


- (IBAction)keyPressed:(UIButton *)sender;

@end
