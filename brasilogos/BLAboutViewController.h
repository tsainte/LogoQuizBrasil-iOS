//
//  BLAboutViewController.h
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface BLAboutViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *evaluateButton;
@property (weak, nonatomic) IBOutlet UIButton *sendEmailButton;

- (IBAction)evaluateTapped:(id)sender;
- (IBAction)sendEmailTapped:(id)sender;

@end
