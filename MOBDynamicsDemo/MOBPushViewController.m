//
//  MOBPushViewController.m
//  MOBDynamicsDemo
//
//  Created by Craig Stanford on 13/08/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "MOBPushViewController.h"

@interface MOBPushViewController ()

@property (nonatomic, strong) IBOutlet UIView* alertView;
@property (nonatomic, strong) IBOutlet UIView* blueBoxView;
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UIPushBehavior* pushBehaviour;
@property (nonatomic, strong) UICollisionBehavior* collisionBehaviour;
@property (nonatomic, strong) UIDynamicItemBehavior* itemBehaviour;


- (IBAction)buttonPressed:(id)sender;

@end

@implementation MOBPushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)buttonPressed:(id)sender
{
    self.collisionBehaviour = [[UICollisionBehavior alloc] initWithItems:@[
                                                                           self.alertView,
                                                                           self.blueBoxView,
                                                                           ]];
    self.collisionBehaviour.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collisionBehaviour];

//    self.pushBehaviour = [[UIPushBehavior alloc] initWithItems:@[self.alertView] mode:UIPushBehaviorModeContinuous];
    self.pushBehaviour = [[UIPushBehavior alloc] initWithItems:@[self.alertView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehaviour.angle = M_PI_2 * rand();
    self.pushBehaviour.magnitude = 10.f;
    [self.animator addBehavior:self.pushBehaviour];
    
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.alertView]];
    self.itemBehaviour.elasticity = 1.f;
    self.itemBehaviour.friction = 1.f;
    [self.animator addBehavior:self.itemBehaviour];
}

@end
