//
//  BLAboutViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLAboutViewController.h"
#import "iRate.h"
#import <iRate/iRate.h>

@interface BLAboutViewController ()

@end

@implementation BLAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [BLStyling roundView:self.evaluateButton];
    [BLStyling roundView:self.sendEmailButton];
}

- (IBAction)evaluateTapped:(id)sender {
    
    [[iRate sharedInstance] openRatingsPageInAppStore];
}

- (IBAction)sendEmailTapped:(id)sender {
    
    NSArray *toRecipents = @[@"ios@mobwiz.com.br"];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    
    [mc setToRecipients:toRecipents];
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result) {
        case MFMailComposeResultCancelled:
            [self.view makeToast:@"E-Mail cancelado"];
            break;
        case MFMailComposeResultSaved:
            [self.view makeToast:@"E-Mail salvo"];
            break;
        case MFMailComposeResultSent:
            [self.view makeToast:@"E-Mail enviado"];
            break;
        case MFMailComposeResultFailed:
            [self.view makeToast:@"Falha ao enviar"];
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
