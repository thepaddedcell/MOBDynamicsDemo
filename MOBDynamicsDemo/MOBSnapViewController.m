//
//  MOBSnapViewController.m
//  MOBDynamicsDemo
//
//  Created by Craig Stanford on 13/08/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "MOBSnapViewController.h"

@interface MOBSnapViewController ()

@property (nonatomic, strong) IBOutlet UIView* alertView;
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UISnapBehavior* snapBehaviour;

- (IBAction)buttonPressed:(id)sender;

@end

@implementation MOBSnapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setupSnapBehaviour];
}

- (void)setupSnapBehaviour
{
    self.snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.alertView snapToPoint:self.view.center];
//    self.snapBehaviour.damping = 0.1f;
    [self.animator addBehavior:self.snapBehaviour];
    
////***********************************************************
//    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.alertView]];
//    itemBehaviour.allowsRotation = NO;
//    [self.animator addBehavior:itemBehaviour];
////***********************************************************

}

- (void)buttonPressed:(id)sender
{
    [self.animator removeAllBehaviors];
    self.snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.alertView snapToPoint:CGPointMake(500, 500)];
    [self.animator addBehavior:self.snapBehaviour];
}

- (void)viewTapped:(id)sender
{
    [self.animator removeAllBehaviors];
    self.snapBehaviour = nil;
    CGRect alertFrame = self.alertView.frame;
    alertFrame.origin.y = -200;
    alertFrame.origin.x = CGRectGetWidth(self.view.bounds)/2 - CGRectGetWidth(self.alertView.bounds)/2;
    self.alertView.frame = alertFrame;
    [self setupSnapBehaviour];
}


@end
