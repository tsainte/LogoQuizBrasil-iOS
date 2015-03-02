//
//  BLLogoViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLLogoViewController.h"
#import "Toast+UIView.h"
#import "BLAlertOverlayViewController.h"

@interface BLLogoViewController ()

@property BOOL isCorrect;
@property CGPoint ipadLandscapeScroll;
@end

@implementation BLLogoViewController

#define kKeyLetter 0
#define kKeyBackspace 100
#define kKeySpace 101
#define kKeyEnter 102

typedef enum
{
	BLTextFieldIdle,
  BLTextFieldCorrect,
  BLTextFieldWrong
} BLTextFieldState;
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
  
  [self updateIsCorrect];
  [self roundThings];
  [self updateImage];
  [self updateCoins];
  [self configureTextView];
  [self configureConstraints];

}

- (void)configureConstraints {
  
  if ([BLController isIpad]) {
    self.heightViewConstraint.constant = [[UIScreen mainScreen] bounds].size.height;
    self.widthViewConstraint.constant = [[UIScreen mainScreen] bounds].size.width;
  } else {
      self.heightViewConstraint.constant = [[UIScreen mainScreen] bounds].size.height;
  }
}
- (void)updateIsCorrect {
  
  BLLogoStatus* status = [BLDatabaseManager logoStatus:[self.logo[@"id"] longValue]];
  self.isCorrect = status.hasHitTheAnswer;
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

- (void)updateImage {
  
  NSString* imageName = self.isCorrect ? self.logo[@"imagem"] : self.logo[@"imagemModificada"];
  
  self.logoImage.image = [UIImage imageNamed:imageName];
}

- (void)updateCoins {
  
  self.coinsLabel.text = [@([[BLDatabaseManager wallet] coins]) description];
}

- (void)configureTextView {
  
//  [self hideTextField];
  BLTextFieldState state = self.isCorrect ? BLTextFieldCorrect : BLTextFieldIdle;
  [self configureTextFieldForState:state];
}

- (void)hideTextField {
  
//   Hide keyboard, but show blinking cursor
    UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.answerTextField.inputView = dummyView;
}

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:YES];
  [self loadBanner];
//  NSLog(@"constraint: %f", self.heightPanelConstraint.constant);
//  self.heightPanelConstraint.constant = [BLController isIphone5] ? 210.0f : 160.0f;
//  [self.view setNeedsUpdateConstraints];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  
  if ([BLController isIpad] && UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
      self.ipadLandscapeScroll = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
      [self.scrollView setContentOffset:self.ipadLandscapeScroll animated:YES];
    
  } else
  if (![BLController isIphone5])
    [self.scrollView setContentOffset:CGPointMake(0, -40) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  
  if ([BLController isIpad] && UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
      [self.scrollView setContentOffset:[self invertPoint:self.ipadLandscapeScroll] animated:YES];
  } else
  if (![BLController isIphone5])
    [self.scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
  
  [self tryAnswer];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  
  [textField resignFirstResponder];
  return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  if ([BLController isIpad]) {
//    self.heightViewConstraint.constant = [[UIScreen mainScreen] bounds].size.height;
    self.widthViewConstraint.constant = [[UIScreen mainScreen] bounds].size.width - 8;
  }
}
- (IBAction)shopTapped:(id)sender {
  
  [BLController showShoppingOnViewController:self];
}

#pragma mark - Keyboard methods

- (IBAction)keyPressed:(UIButton *)key {
  
  if (self.isCorrect) return;
  [self configureTextFieldForState:BLTextFieldIdle];
  
  switch (key.tag) {
    case kKeyLetter:
      [self putKey:key.titleLabel.text];
      break;
    case kKeyBackspace:
      [self removeLastKey];
      break;
    case kKeySpace:
      [self putKey:@" "];
      break;
    case kKeyEnter:
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

- (void)updateElements {
  
  [self updateIsCorrect];
  [self updateImage];
  [self updateCoins];
}
#pragma mark - actions

- (IBAction)clueOneTapped:(id)sender {
  
  if (![self.gameManager alreadyPurchased:BLGameHelpClueOne]) {
    [self showAlertWithTitle:@"Dica 1" text:@"Você deseja revelar primeira dica por 10 moedas?" action:^{
      [self authorizeClue:BLGameHelpClueOne];
    }];
  } else {
    [self authorizeClue:BLGameHelpClueOne];
  }
  
}

- (IBAction)clueTwoTapped:(id)sender {
  
  if (![self.gameManager alreadyPurchased:BLGameHelpClueTwo]) {
    [self showAlertWithTitle:@"Dica 2" text:@"Você deseja revelar segunda dica por 10 moedas?" action:^{
      [self authorizeClue:BLGameHelpClueTwo];
    }];
  } else {
    [self authorizeClue:BLGameHelpClueTwo];
  }
}

- (IBAction)sloganTapped:(id)sender {
  
  if (![self.gameManager alreadyPurchased:BLGameHelpSlogan]) {
  [self showAlertWithTitle:@"Slogan" text:@"Você deseja revelar slogan por 20 moedas?" action:^{
    [self authorizeClue:BLGameHelpSlogan];
  }];
  } else {
    [self authorizeClue:BLGameHelpSlogan];
  }

}

- (IBAction)bombTapped:(id)sender {
  
  if (![self.gameManager alreadyPurchased:BLGameHelpBomb]) {
  [self showAlertWithTitle:@"Bomba" text:@"Você deseja usar bomba por 50 moedas?" action:^{
    [self bomb];
  }];
  } else {
    [self bomb];
  }
  
}

- (IBAction)magicTapped:(id)sender {
  
  if (![self.gameManager alreadyPurchased:BLGameHelpMedicine]) {
  [self showAlertWithTitle:@"Mágica" text:@"Você deseja revelar logo por 200 moedas?" action:^{
    [self medicine];
  }];
  } else {
    [self medicine];
  }
}

#pragma mark - clues
- (void)authorizeClue:(BLGameHelp)type {
  
  BOOL success = [self.gameManager authorizeHelp:type];
  if (success) {
    [self updateElements];
    [self showClue:type];
  }
}

- (void)showClue:(BLGameHelp)type {
  
  NSString* clue = [self getClue:type];
  [self.view makeToast:clue position:[self getPoint] color:kColorDarkGreen];
}

- (NSValue*)getPoint {
  
  CGSize size = self.view.bounds.size;
  CGFloat height = (size.height / 100) * 65;
  CGPoint point = CGPointMake(size.width / 2,  height);
  NSValue* value = [NSValue valueWithCGPoint:point];
  return value;
}

- (NSString*)getClue:(BLGameHelp)type {

  NSString* clue;
  switch (type) {
    case BLGameHelpClueOne:
      clue = self.logo[@"dica1"];
      break;
    case BLGameHelpClueTwo:
      clue = self.logo[@"dica2"];
      break;
    case BLGameHelpSlogan:
      clue = self.logo[@"slogan"];
      break;
    default:
      break;
  }
  return clue;
}
#pragma mark - Bomb

- (void)bomb {
  
  BOOL authorized = [self.gameManager authorizeHelp:BLGameHelpBomb];
  if (authorized) {
    [self hideLetters];
    [self updateElements];
  }
}

- (void)hideLetters {
  
  NSString* answer = [self.logo[@"nome"] lowercaseString];
  for (UIButton* key in self.keyboard.subviews) {
    if (key.tag == kKeyLetter) {
      NSString* letter = [key.titleLabel.text lowercaseString];
      BOOL hasLetter = [answer rangeOfString:letter].location != NSNotFound;
      if (!hasLetter) {
        [self hideLetter:key];
      }
    }
  }
}

- (void)hideLetter:(UIButton*)letter {
  
  [UIView animateWithDuration:0.5 animations:^{
    letter.alpha = 0;
  }];
}

#pragma mark - Medicine

- (void)medicine {
  
  BOOL authorized = [self.gameManager authorizeHelp:BLGameHelpMedicine];
  if (authorized) {
    [self updateElements];
    [self configureTextFieldForState:BLTextFieldCorrect];
  }
}
#pragma mark - BLGameManagerDelegate

- (void)isCorrectAnswer {
 
  [BLController playSound:@"correct" type:@"mp3"];
  [self updateElements];
  [self configureTextFieldForState:BLTextFieldCorrect];
}

- (void)isWrongAnswer {
  
  [self configureTextFieldForState:BLTextFieldWrong];
  [BLController playSound:@"fail" type:@"mp3"];
}


#pragma mark - alert
- (void)showAlertWithTitle:(NSString*)title text:(NSString*)text action:(void(^)(void))executeAction {
  
  BLAlertOverlayViewController* alert = [self.storyboard instantiateViewControllerWithIdentifier:@"BLAlertOverlayViewController"];
  
  alert.titleText = title;
  alert.text = text;
  alert.executeAction = executeAction;
  
  if (IS_OS_8_OR_LATER) {
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
  } else {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
  }
  
  [self presentViewController:alert animated:NO completion:nil];
}


- (void)configureTextFieldForState:(BLTextFieldState)state {
  
  switch (state) {
    case BLTextFieldIdle:
      self.answerTextField.superview.backgroundColor = kColorDarkGreen;
      self.answerTextField.alpha = 1.0;
      self.answerTextField.enabled = YES;
      break;
    case BLTextFieldCorrect:
      self.answerTextField.text = self.logo[@"nome"];
      self.answerTextField.enabled = NO;
      self.answerTextField.alpha = 0.6;
      self.answerTextField.superview.backgroundColor = kColorDarkGreen;
      break;
    case BLTextFieldWrong:
      self.answerTextField.superview.backgroundColor = kColorRed;
      self.answerTextField.alpha = 0.6;
      self.answerTextField.enabled = YES;
      break;
      
    default:
      break;
  }
}

#pragma mark - BLBannerManagerDelegate

- (void)loadBanner {
  
  [[BLBannerManager shared] resetAdView:self];
}

- (void)bannerWillAppear:(UIView *)banner {
  
  if (![self.adBanner.subviews containsObject:banner]) {
    [self.adBanner addSubview:banner];
  }
}

- (void)bannerWillDisappear:(UIView *)banner {
  
  [banner removeFromSuperview];
}
- (IBAction)viewDidTapped:(id)sender {
  
  [self.answerTextField resignFirstResponder];
  if ([BLController isIpad] && UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
    [self.scrollView setContentOffset:[self invertPoint:self.ipadLandscapeScroll] animated:YES];
  }
}
- (CGPoint)invertPoint:(CGPoint)originalPoint {
  
  return CGPointMake(originalPoint.x, -originalPoint.y);
}
@end
