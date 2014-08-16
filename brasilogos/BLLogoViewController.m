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
  
  self.gameManager = [[BLGameManager alloc] initWithLogo:self.logo delegate:self];
  
  [self roundThings];
  [self updateImage];
  
  UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
  self.answerTextField.inputView = dummyView; // Hide keyboard, but show blinking cursor
}

- (void)updateImage {
  
  
  NSString* entity = [NSString stringWithFormat:kEntityLogoStatusID,[self.logo[@"id"] longValue]];
  BLLogoStatus* status = (BLLogoStatus*)[BLDatabaseManager loadDataFromEntity:entity];
  
  NSString* imageName = status.hasHitTheAnswer ? self.logo[@"imagem"] : self.logo[@"imagemModificada"];
  
  self.logoImage.image = [UIImage imageNamed:imageName];
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

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:YES];
  NSLog(@"constraint: %f", self.heightPanelConstraint.constant);
  self.heightPanelConstraint.constant = [BLStyling isIphone5] ? 210.0f : 160.0f;
  [self.view setNeedsUpdateConstraints];
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

#pragma mark - Keyboard methods
- (IBAction)keyPressed:(UIButton *)key {
  
  switch (key.tag) {
    case 0:
      [self putKey:key.titleLabel.text];
      break;
    case 100:
      [self removeLastKey];
      break;
    case 101:
      [self putKey:@" "];
      break;
    case 102:
      [self tryAnswer];
      break;
    default:
      break;
  }
}

- (void)putKey:(NSString*)letter {
  
  [self.answerTextField becomeFirstResponder];
  NSString* text = self.answerTextField.text;
  text = [NSString stringWithFormat:@"%@%@",text, [letter lowercaseString]];
  self.answerTextField.text = text;
}

- (void)removeLastKey {
  
  [self.answerTextField becomeFirstResponder];
  NSString* text = self.answerTextField.text;
  NSInteger lastIndex = text.length;
  if (lastIndex) {
    text = [text substringToIndex:lastIndex-1];
  }
  self.answerTextField.text = text;
}

- (void)tryAnswer {
  
  [self.answerTextField resignFirstResponder];
  [self.gameManager tryAnswer:self.answerTextField.text];
}

#pragma mark - BLGameManagerDelegate

- (void)isCorrectAnswer {
 
  [self updateImage];
}

- (void)isWrongAnswer {
  
}

@end
