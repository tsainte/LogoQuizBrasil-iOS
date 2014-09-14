//
//  BLLogoViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLLogoViewController.h"
#import "Toast+UIView.h"
#import "BLShoppingOverlayViewController.h"
@interface BLLogoViewController ()

@property BOOL isCorrect;

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
  
  // Hide keyboard, but show blinking cursor
  UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
  self.answerTextField.inputView = dummyView;
  BLTextFieldState state = self.isCorrect ? BLTextFieldCorrect : BLTextFieldIdle;
  [self configureTextFieldForState:state];
}
- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:YES];
  [self loadBanner];
  NSLog(@"constraint: %f", self.heightPanelConstraint.constant);
  self.heightPanelConstraint.constant = [BLController isIphone5] ? 210.0f : 160.0f;
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
  
  [self authorizeClue:BLGameHelpClueOne];
}

- (IBAction)clueTwoTapped:(id)sender {
  
  [self authorizeClue:BLGameHelpClueTwo];
}

- (IBAction)sloganTapped:(id)sender {
  
  [self authorizeClue:BLGameHelpSlogan];
}

- (IBAction)bombTapped:(id)sender {
  
  [self bomb];
}

- (IBAction)magicTapped:(id)sender {
  
  [self medicine];
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
@end
