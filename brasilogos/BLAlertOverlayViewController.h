//
//  BLAlertOverlayViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 20/09/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLAlertOverlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;

@property NSString *titleText;
@property NSString *text;
@property (copy) void (^executeAction)(void);

- (IBAction)noTapped:(id)sender;
- (IBAction)yesTapped:(id)sender;

@end
