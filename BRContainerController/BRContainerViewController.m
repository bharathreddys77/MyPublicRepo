//
//  BRContainerViewController.m
//  BRContainerController
//
//  Created by Bharath V on 14/08/15.
//  Copyright (c) 2015 BR. All rights reserved.
//

#import "BRContainerViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#define First_Segue @"first_segue"
#define Second_segue @"second_segue"
#define Third_segue @"third_segue"


@interface BRContainerViewController ()

@property (nonatomic, weak) NSString * currentSegueIdentifier;
@property (assign, nonatomic) BOOL transitionInProgress;

@property (nonatomic, strong) FirstViewController * firstViewController;
@property (nonatomic, strong) SecondViewController * secondViewController;
@property (nonatomic, strong) ThirdViewController * thirdViewCOntroller;
@property (nonatomic, strong) UIViewController * currentFrontCntroller;

@end

@implementation BRContainerViewController

- (void)showControllerWithType:(BTN_TYPE)cntrlType {
    self.transitionInProgress = NO;
    if(self.currentSegueIdentifier != nil && ! [self.currentSegueIdentifier isKindOfClass:[NSNull class]]) {
        
        if([self.currentSegueIdentifier isEqualToString:First_Segue] && cntrlType == BTN_CNTRL1) return;
        else if([self.currentSegueIdentifier isEqualToString:Second_segue] && cntrlType == BTN_CNTRL2) return;
        else if([self.currentSegueIdentifier isEqualToString:Third_segue] && cntrlType == BTN_CNTRL3) return;

        if([self.currentSegueIdentifier isEqualToString:First_Segue]) self.currentFrontCntroller = self.firstViewController;
        else if([self.currentSegueIdentifier isEqualToString:Second_segue]) self.currentFrontCntroller = self.secondViewController;
        else if([self.currentSegueIdentifier isEqualToString:Third_segue]) self.currentFrontCntroller = self.thirdViewCOntroller;
    }
    
    if(cntrlType == BTN_CNTRL1) self.currentSegueIdentifier = First_Segue;
    else if(cntrlType == BTN_CNTRL2) self.currentSegueIdentifier = Second_segue;
    else if(cntrlType == BTN_CNTRL3) self.currentSegueIdentifier = Third_segue;
    
    [self swapViewControllers];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:First_Segue]) self.firstViewController = [segue destinationViewController];
    else if ([segue.identifier isEqualToString:Second_segue]) self.secondViewController = [segue destinationViewController];
    else if ([segue.identifier isEqualToString:Third_segue]) self.thirdViewCOntroller = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:First_Segue])
    {
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.firstViewController];
        }
        else {
            [self addViewToContainerViewInitially:segue];
        }
    } else if ([segue.identifier isEqualToString:Second_segue])
    {
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.secondViewController];
        }
        else {
            [self addViewToContainerViewInitially:segue];
        }
    } else if ([segue.identifier isEqualToString:Third_segue])
    {
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.thirdViewCOntroller];
        }
        else {
            [self addViewToContainerViewInitially:segue];
        }
    }
}

- (void)addViewToContainerViewInitially:(UIStoryboardSegue *)segue {
    // Add view to container at very first time run
    [self addChildViewController:segue.destinationViewController];
    UIView* destView = ((UIViewController *)segue.destinationViewController).view;
    destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:destView];
    [segue.destinationViewController didMoveToParentViewController:self];
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }];
}

- (UIViewController *)getCurrentFrontViewController {
    if([self.currentSegueIdentifier isEqualToString:First_Segue]) return self.firstViewController;
    else if ([self.currentSegueIdentifier isEqualToString:Second_segue]) return self.secondViewController;
    else return self.thirdViewCOntroller;
}

- (void)swapViewControllers
{
    if (self.transitionInProgress) {
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:First_Segue]) && self.firstViewController) {
        [self swapFromViewController:self.currentFrontCntroller toViewController:self.firstViewController];
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:Second_segue]) && self.secondViewController) {
        [self swapFromViewController:self.currentFrontCntroller toViewController:self.secondViewController];
        return;
    }

    if (([self.currentSegueIdentifier isEqualToString:Third_segue]) && self.thirdViewCOntroller) {
        [self swapFromViewController:self.currentFrontCntroller toViewController:self.thirdViewCOntroller];
        return;
    }

    
    self.transitionInProgress = YES;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}


@end
