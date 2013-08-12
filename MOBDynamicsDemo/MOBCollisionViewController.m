//
//  MOBCollisionViewController.m
//  MOBDynamicsDemo
//
//  Created by Craig Stanford on 12/08/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "MOBCollisionViewController.h"

@interface MOBCollisionViewController ()

@property (nonatomic, strong) IBOutlet UIView* alertView;
@property (nonatomic, strong) IBOutlet UIView* thinBlueLine;
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UIGravityBehavior* gravityBehaviour;
@property (nonatomic, strong) UICollisionBehavior* collisionBehaviour;

- (IBAction)buttonPressed:(id)sender;

@end

@implementation MOBCollisionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setupBehaviours];
}

- (void)setupBehaviours
{
    self.gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.alertView]];
    self.collisionBehaviour = [[UICollisionBehavior alloc] initWithItems:@[self.alertView]];
    [self.collisionBehaviour addBoundaryWithIdentifier:@"ThinBlueLine"
                                             fromPoint:CGPointMake(0, CGRectGetMinY(self.thinBlueLine.frame))
                                               toPoint:CGPointMake(CGRectGetWidth(self.thinBlueLine.frame), CGRectGetMinY(self.thinBlueLine.frame))];
    [self.animator addBehavior:self.gravityBehaviour];
    [self.animator addBehavior:self.collisionBehaviour];
}

- (IBAction)buttonPressed:(id)sender
{
    [self.animator removeBehavior:self.collisionBehaviour];
}

- (void)viewTapped:(id)sender
{
    if (self.gravityBehaviour) {
        [self.animator removeAllBehaviors];
        CGRect alertFrame = self.alertView.frame;
        alertFrame.origin.y = 50;
        self.alertView.frame = alertFrame;
        [self setupBehaviours];
    }
}

@end
