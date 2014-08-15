//
//  BLIndexLevelViewController.m
//  brasilogos
//
//  Created by Tiago Bencardino on 15/08/14.
//  Copyright (c) 2014 MobWiz. All rights reserved.
//

#import "BLIndexLevelViewController.h"

@interface BLIndexLevelViewController ()

@property NSArray* levels;

@end

@implementation BLIndexLevelViewController

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
  self.levels = @[@1,@2,@3,@2,@3,@2,@3,@2,@3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
  return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.levels.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString* cellIdentifier = @"cell";
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (cell == nil) {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  return cell;
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
