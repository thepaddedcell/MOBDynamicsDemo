//
//  MOBGravityViewController.m
//  MOBDynamicsDemo
//
//  Created by Craig Stanford on 12/08/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "MOBGravityViewController.h"

@interface MOBGravityViewController ()

@property (nonatomic, strong) IBOutlet UIView* alertView;
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UIGravityBehavior* gravityBehaviour;



- (IBAction)buttonPressed:(id)sender;

@end

@implementation MOBGravityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //** UIKit Dynamics incoming!
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewTapped:(id)sender
{
    if (self.gravityBehaviour) {
        [self.animator removeBehavior:self.gravityBehaviour];
        self.alertView.center = self.view.center;
    }
}

- (IBAction)buttonPressed:(id)sender
{
    self.gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.alertView]];
    [self.animator addBehavior:self.gravityBehaviour];
}

@end
