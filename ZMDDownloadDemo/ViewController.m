//
//  ViewController.m
//  ZMDDownloadDemo
//
//  Created by Zian Chen on 8/27/13.
//  Copyright (c) 2013 Zian Mobile Development. All rights reserved.
//

#import "ViewController.h"
#import "ZMDDownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSArray *fetchURLStrings = @[@"jack johnson",
                                 @"priscilla",
                                 @"nadia",
                                 @"allin",
                                 @"dave alvin",
                                 @"anastacia",
                                 @"ken andrew",
                                 @"michael andrews",
                                 @"david archuleta",
                                 @"billie joe",
                                 @"louis armstrong",
                                 @"joseph arthur",
                                 @"chuck",
                                 @"crystal",
                                 @"sara bareilles",
                                 @"jon bon"
                                 ];
    
    NSArray *priorityArray = @[@"chuck",
                               @"crystal",
                               @"sara bareilles",
                               @"jon bon"];
    
    for (NSString *searchTerm in fetchURLStrings) {
        [[ZMDDownloadManager sharedInstance] fetchWithTerm:searchTerm withPriority:NSOperationQueuePriorityNormal];
    }
    
    [[ZMDDownloadManager sharedInstance] prioritizeRequestNames:priorityArray];
    
    //[[ZMDDownloadManager sharedInstance] checkOperations];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
