//
//  MessageSecondViewController.m
//  TabBarExampleApp
//
//  Created by Nicolas on 12/19/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "MessageSecondViewController.h"

@interface MessageSecondViewController ()

@end

@implementation MessageSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[UIAlertView alloc] initWithTitle:@"SecondPage"
                                      message:@"Here goes your 2nd message buddy!"
                                      delegate:self
                          cancelButtonTitle:@"ROFL"
                          otherButtonTitles:@"RLY?", nil]show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation





@end
