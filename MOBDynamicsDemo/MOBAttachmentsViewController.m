//
//  MOBAttachmentsViewController.m
//  MOBDynamicsDemo
//
//  Created by Craig Stanford on 12/08/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "MOBAttachmentsViewController.h"

@interface MOBAttachmentsViewController ()

@property (nonatomic, strong) IBOutlet UIView* alertView;
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UIGravityBehavior* gravityBehaviour;
@property (nonatomic, strong) UIAttachmentBehavior* leftAttachment;
@property (nonatomic, strong) UIAttachmentBehavior* rightAttachment;
@property (nonatomic, strong) UIAttachmentBehavior* panAttachment;
@property (nonatomic, strong) UIAttachmentBehavior* attachmentBehaviour;

- (IBAction)buttonPressed:(id)sender;

@end

@implementation MOBAttachmentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.alertView]];
    [self.animator addBehavior:self.gravityBehaviour];
    
    [self setupAttachments];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPanned:)];
    [self.view addGestureRecognizer:pan];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)setupAttachments
{
    UIOffset leftOffset = UIOffsetMake(-CGRectGetWidth(self.alertView.bounds)/2 + 5, 0);
    self.leftAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.alertView
                                                    offsetFromCenter:leftOffset
                                                    attachedToAnchor:CGPointMake(-CGRectGetWidth(self.view.bounds), 0)];
    self.leftAttachment.damping = 0.25f;
    self.leftAttachment.frequency = 1.f;
    [self.animator addBehavior:self.leftAttachment];
    
    UIOffset rightOffset = UIOffsetMake(CGRectGetWidth(self.alertView.bounds)/2 - 5, 0);
    self.rightAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.alertView
                                                     offsetFromCenter:rightOffset
                                                     attachedToAnchor:CGPointMake(CGRectGetWidth(self.view.bounds) * 2, 0)];
    self.rightAttachment.damping = 0.25f;
    self.rightAttachment.frequency = 1.f;
    [self.animator addBehavior:self.rightAttachment];
    
////***********************************************************
//    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.alertView]];
//    itemBehaviour.allowsRotation = NO;
//    [self.animator addBehavior:itemBehaviour];
////***********************************************************
    
}

- (void)viewPanned:(UIPanGestureRecognizer*)panGesture
{
    CGPoint point = [panGesture translationInView:self.view];
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //Add the attachment
            self.panAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.alertView attachedToAnchor:point];
            [self.animator addBehavior:self.panAttachment];
            break;
        }
        case UIGestureRecognizerStateChanged:
            //Move the attachment
            self.panAttachment.anchorPoint = point;
            break;
        case UIGestureRecognizerStateEnded:
            //Remove the attachment
            [self.animator removeBehavior:self.panAttachment];
            break;
        default:
            break;
    }
}

- (void)viewTapped:(id)sender
{
    if (self.gravityBehaviour) {
        [self.animator removeAllBehaviors];
        CGRect alertFrame = self.alertView.frame;
        alertFrame.origin.y = 50;
        self.alertView.frame = alertFrame;
        [self setupAttachments];
        [self.animator addBehavior:self.gravityBehaviour];
    }
}

- (void)buttonPressed:(id)sender
{
    [self.animator removeBehavior:self.leftAttachment];
    [self.animator removeBehavior:self.rightAttachment];
}

@end
