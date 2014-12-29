//
//  MessageFirstViewController.m
//  TabBarExampleApp
//
//  Created by Nicolas on 12/19/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "MessageFirstViewController.h"

@interface MessageFirstViewController ()

@end

@implementation MessageFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[UIAlertView alloc] initWithTitle:@"FirstPage" message:@"Welcome, here's your 1st message" delegate:self cancelButtonTitle:@"duh" otherButtonTitles:nil, nil]show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation



@end
