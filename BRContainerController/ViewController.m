//
//  ViewController.m
//  BRContainerController
//
//  Created by Bharath V on 14/08/15.
//  Copyright (c) 2015 BR. All rights reserved.
//

#import "ViewController.h"
#import "BRContainerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) BRContainerViewController * containerCntrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"embeddedCntrl"]) {
        self.containerCntrl = segue.destinationViewController;
    }
}

- (IBAction)btnTapped:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if(btn.tag == 0) {
        [self.containerCntrl showControllerWithType:BTN_CNTRL1];
    } else if(btn.tag == 1) {
        [self.containerCntrl showControllerWithType:BTN_CNTRL2];
    } else if(btn.tag == 2) {
        [self.containerCntrl showControllerWithType:BTN_CNTRL3];
    }
}


@end
