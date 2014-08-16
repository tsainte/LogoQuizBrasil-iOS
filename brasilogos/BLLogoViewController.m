//
//  BLLogoViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLLogoViewController.h"

@interface BLLogoViewController ()

@end

@implementation BLLogoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self roundThings];
  self.logoImage.image = [UIImage imageNamed:self.logo[@"imagemModificada"]];
  UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
  self.answerTextField.inputView = dummyView; // Hide keyboard, but show blinking cursor
  self.answerTextField.text = @"asdfadsf";
}

- (void)roundThings {

  [BLStyling roundView:[self.view viewWithTag:1] corner:12];
  [BLStyling roundView:[self.view viewWithTag:2] corner:8];
  [BLStyling roundView:[self.view viewWithTag:3] corner:12];
  [BLStyling roundView:self.answerTextField corner:8];
  [self roundKeys];
}

- (void)roundKeys {
  
  for (UIView* key in self.keyboard.subviews) {
    
    [BLStyling roundView:key corner:6];
  }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
