//
//  MOBViewController.m
//  MOBDynamicsDemo
//
//  Created by Craig Stanford on 12/08/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "MOBViewController.h"

@interface MOBViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* menuItems;


@end

@implementation MOBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuItems = @[@"Gravity", @"Collision", @"Attachments", @"Snap", @"Push",];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* item = self.menuItems[indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@Cell", item] forIndexPath:indexPath];
    cell.textLabel.text = item;
    return cell;
}

@end
