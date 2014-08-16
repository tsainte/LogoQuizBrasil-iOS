//
//  BLLogoViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLLogoViewController : UIViewController

@property NSDictionary* logo;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UIView *keyboard;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@end
