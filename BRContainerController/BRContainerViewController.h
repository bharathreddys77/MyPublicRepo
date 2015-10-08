//
//  BRContainerViewController.h
//  BRContainerController
//
//  Created by Bharath V on 14/08/15.
//  Copyright (c) 2015 BR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {BTN_CNTRL1 = 0,BTN_CNTRL2,BTN_CNTRL3}BTN_TYPE;

@interface BRContainerViewController : UIViewController

- (void)showControllerWithType:(BTN_TYPE)cntrlType;
- (UIViewController *)getCurrentFrontViewController;

@end
